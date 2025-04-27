// core/app_data/api/graphql/graphql_client.dart
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import '../../local_storage/local_storage_client.dart';
import '../../local_storage/storage_keys.dart';
import 'graphql_constants.dart';

/// A configuration class for GraphQL client setup
class GraphQLConfig {
  final LocalStorageClient _localStorageClient;
  final Logger _logger;
  bool _hiveInitialized = false;
  static const String _graphqlBoxName = 'graphql-cache';

  GraphQLConfig({
    required LocalStorageClient localStorageClient,
    Logger? logger,
  }) : _localStorageClient = localStorageClient,
       _logger = logger ?? Logger();

  Future<ValueNotifier<GraphQLClient>> initializeClient() async {
    try {
      // Initialize Hive if not already done
      if (!_hiveInitialized) {
        await initHive();
      }
      
      final String? token = await _localStorageClient.getSecuredData(StorageKeys.token);
      
      final isGuest = _getIsGuestStatus();
      
      return _createClient(token, isGuest);
    } catch (e) {
      _logger.e('Failed to initialize GraphQL client: $e');
      return _createClient(null, false);
    }
  }
  
  Future<void> initHive() async {
    try {
      // Initialize Hive
      await Hive.initFlutter();
      // Initialize the box for GraphQL
      await HiveStore.open(boxName: _graphqlBoxName);
      _hiveInitialized = true;
      _logger.d('Hive initialized successfully for GraphQL');
    } catch (e) {
      _logger.e('Error initializing Hive: $e');
      rethrow;
    }
  }
  
  bool _getIsGuestStatus() {
    try {
      final isGuestStr = _localStorageClient.getData(StorageKeys.isGuest);
      return isGuestStr != null ? isGuestStr.toLowerCase() == 'true' : false;
    } catch (e) {
      _logger.e('Error getting guest status: $e');
      return false;
    }
  }

  ValueNotifier<GraphQLClient> _createClient(String? token, bool isGuest) {
    final httpLink = HttpLink(
      GraphQLConstants.endpoint,
    );

    final authLink = AuthLink(
      getToken: () {
        if (token == null) return '';
        
        if (isGuest) {
          return 'Bearer $token Guest';
        } else {
          return 'Bearer $token';
        }
      },
    );

    final link = authLink.concat(httpLink);

    final errorLink = ErrorLink(
      onGraphQLError: (request, forward, response) {
        _logger.e('GraphQL Error: ${response.errors}');
        return forward(request);
      },
      onException: (request, forward, exception) {
        _logger.e('GraphQL Exception: $exception');
        return forward(request);
      },
    );

    final finalLink = errorLink.concat(link);

    try {
      return ValueNotifier(
        GraphQLClient(
          link: finalLink,
          cache: GraphQLCache(
            store: HiveStore(
               Hive.box<Map<dynamic, dynamic>?>(
                _graphqlBoxName,
              ),
            ),
          ),
          defaultPolicies: DefaultPolicies(
            query: Policies(
              fetch: FetchPolicy.networkOnly,
            ),
            mutate: Policies(
              fetch: FetchPolicy.networkOnly,
            ),
            subscribe: Policies(
              fetch: FetchPolicy.networkOnly,
            ),
          ),
        ),
      );
    } catch (e) {
      _logger.e('Error creating GraphQL client: $e');
      // Fallback to memory store if Hive fails
      return ValueNotifier(
        GraphQLClient(
          link: finalLink,
          cache: GraphQLCache(),
          defaultPolicies: DefaultPolicies(
            query: Policies(
              fetch: FetchPolicy.networkOnly,
            ),
            mutate: Policies(
              fetch: FetchPolicy.networkOnly,
            ),
            subscribe: Policies(
              fetch: FetchPolicy.networkOnly,
            ),
          ),
        ),
      );
    }
  }
}
