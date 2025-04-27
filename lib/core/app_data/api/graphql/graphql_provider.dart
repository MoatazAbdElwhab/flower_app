// core/app_data/api/graphql/graphql_provider.dart
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql_client.dart';
import 'graphql_service.dart';

class AppGraphQLProvider {
  final GraphQLConfig _graphQLConfig;
  late ValueNotifier<GraphQLClient> _clientNotifier;
  late GraphQLService _graphQLService;
  bool _isInitialized = false;

  AppGraphQLProvider({
    required GraphQLConfig graphQLConfig,
  }) : _graphQLConfig = graphQLConfig;


  Future<void> initialize() async {
    if (_isInitialized) return;
    
    _clientNotifier = await _graphQLConfig.initializeClient();
    _graphQLService = GraphQLService(clientNotifier: _clientNotifier);
    _isInitialized = true;
  }

  GraphQLService get graphQLService {
    _checkInitialization();
    return _graphQLService;
  }

  ValueNotifier<GraphQLClient> get clientNotifier {
    _checkInitialization();
    return _clientNotifier;
  }

  void _checkInitialization() {
    if (!_isInitialized) {
      throw Exception('AppGraphQLProvider has not been initialized. Call initialize() first.');
    }
  }
  Future<void> updateToken() async {
    if (!_isInitialized) await initialize();
    
    _clientNotifier = await _graphQLConfig.initializeClient();
    _graphQLService = GraphQLService(clientNotifier: _clientNotifier);
  }
  
  Widget wrapWithClient(Widget child) {
    _checkInitialization();
    
    return GraphQLProvider(
      client: _clientNotifier,
      child: child,
    );
  }
}
