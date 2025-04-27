// core/app_data/api/graphql/graphql_error_handler.dart
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import '../../../error_handling/exceptions/api_exception.dart';
import 'graphql_exception.dart';
import 'graphql_constants.dart';

class GraphQLErrorHandler {
  final Logger _logger;

  GraphQLErrorHandler({Logger? logger}) : _logger = logger ?? Logger();

  Exception handleQueryResultErrors(QueryResult result) {
    if (!result.hasException) return ApiException(message: 'Unknown error');

    final exception = result.exception;
    _logger.e('GraphQL error: ${exception.toString()}');

    if (exception?.linkException is NetworkException) {
      return ApiException(
        message: 'Network error occurred. Please check your connection.',
        statusCode: 503,
      );
    }

    if (exception?.graphqlErrors?.isNotEmpty == true) {
      final graphQLErrors = exception!.graphqlErrors!;
      
      final authError = graphQLErrors.any(
        (error) => error.extensions?['code'] == GraphQLConstants.authErrorCode,
      );
      
      if (authError) {
        return ApiException(
          message: 'Authentication error. Please sign in again.',
          statusCode: 401,
        );
      }
      
      final validationError = graphQLErrors.any(
        (error) => error.extensions?['code'] == GraphQLConstants.validationErrorCode,
      );
      
      if (validationError) {
        return ApiException(
          message: 'Validation error. Please check your input.',
          statusCode: 400,
        );
      }
      
      return ApiException(
        message: graphQLErrors.map((e) => e.message).join(', '),
        statusCode: 400,
      );
    }

    return ApiException(
      message: 'An error occurred while processing your request.',
      statusCode: 500,
    );
  }

  Exception handleGraphQLException(GraphQLException exception) {
    _logger.e('GraphQL exception: ${exception.message}');
    
    if (exception is GraphQLNetworkException) {
      return ApiException(
        message: 'Network error: ${exception.message}',
        statusCode: 503,
      );
    } else if (exception is GraphQLAuthException) {
      return ApiException(
        message: 'Authentication error: ${exception.message}',
        statusCode: 401,
      );
    } else if (exception is GraphQLValidationException) {
      return ApiException(
        message: 'Validation error: ${exception.message}',
        statusCode: 400,
      );
    } else {
      return ApiException(
        message: exception.message,
        statusCode: 500,
      );
    }
  }
}
