import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_data/api/graphql/graphql_client.dart';
import '../app_data/api/graphql/graphql_error_handler.dart';
import '../app_data/api/graphql/graphql_provider.dart';
import '../app_data/api/graphql/graphql_service.dart';
import '../app_data/local_storage/local_storage_client.dart';

@module
abstract class GetItRegisterModule {
  @singleton
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  /// internet
  @singleton
  InternetConnectionChecker get checker =>
      InternetConnectionChecker.createInstance(
        checkTimeout: const Duration(milliseconds: 3800),
      );

  /// local
  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences async =>
      SharedPreferences.getInstance();

  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
  
  /// logger
  @singleton
  Logger get logger => Logger();
  
  /// GraphQL services
  @singleton
  GraphQLConfig provideGraphQLConfig(LocalStorageClient localStorageClient) {
    return GraphQLConfig(
      localStorageClient: localStorageClient,
      logger: logger,
    );
  }

  @singleton
  GraphQLErrorHandler provideGraphQLErrorHandler() {
    return GraphQLErrorHandler(logger: logger);
  }

  @singleton
  @preResolve
  Future<AppGraphQLProvider> provideGraphQLProvider(GraphQLConfig graphQLConfig) async {
    final provider = AppGraphQLProvider(graphQLConfig: graphQLConfig);
    await provider.initialize();
    return provider;
  }

  @singleton
  GraphQLService provideGraphQLService(AppGraphQLProvider graphQLProvider) {
    return GraphQLService(
      clientNotifier: graphQLProvider.clientNotifier,
      logger: logger,
    );
  }
  
  @singleton
  GraphQLClient provideGraphQLClient(AppGraphQLProvider graphQLProvider) {
    return graphQLProvider.clientNotifier.value;
  }
}
