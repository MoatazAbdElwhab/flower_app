// core/app_data/api/graphql/graphql_service.dart
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'graphql_exception.dart';
import 'graphql_error_handler.dart';

class GraphQLService {
  final ValueNotifier<GraphQLClient> _clientNotifier;
  final Logger _logger;
  final GraphQLErrorHandler _errorHandler;
  
  GraphQLService({
    required ValueNotifier<GraphQLClient> clientNotifier,
    Logger? logger,
  }) : _clientNotifier = clientNotifier,
       _logger = logger ?? Logger(),
       _errorHandler = GraphQLErrorHandler(logger: logger);
  
  GraphQLClient get client => _clientNotifier.value;
  
  Future<QueryResult> query({
    required String document,
    Map<String, dynamic>? variables,
    FetchPolicy? fetchPolicy,
  }) async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql(document),
        variables: variables ?? {},
        fetchPolicy: fetchPolicy ?? FetchPolicy.networkOnly,
      );
      
      final result = await client.query(options);
      
      if (result.hasException) {
        throw _errorHandler.handleQueryResultErrors(result);
      }
      
      return result;
    } on GraphQLException catch (e) {
      _logger.e('GraphQL exception in query: ${e.message}');
      throw _errorHandler.handleGraphQLException(e);
    } catch (e) {
      _logger.e('Unexpected error in query: $e');
      rethrow;
    }
  }

  Future<QueryResult> mutate({
    required String document,
    Map<String, dynamic>? variables,
    FetchPolicy? fetchPolicy,
  }) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql(document),
        variables: variables ?? {},
        fetchPolicy: fetchPolicy ?? FetchPolicy.networkOnly,
      );
      
      final result = await client.mutate(options);
      
      if (result.hasException) {
        throw _errorHandler.handleQueryResultErrors(result);
      }
      
      return result;
    } on GraphQLException catch (e) {
      _logger.e('GraphQL exception in mutation: ${e.message}');
      throw _errorHandler.handleGraphQLException(e);
    } catch (e) {
      _logger.e('Unexpected error in mutation: $e');
      rethrow;
    }
  }

  Stream<QueryResult> subscribe({
    required String document,
    Map<String, dynamic>? variables,
  }) {
    try {
      final SubscriptionOptions options = SubscriptionOptions(
        document: gql(document),
        variables: variables ?? {},
      );
      
      return client.subscribe(options);
    } catch (e) {
      _logger.e('Subscription error: $e');
      rethrow;
    }
  }
}
