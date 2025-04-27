// core/app_data/api/graphql/graphql_exception.dart
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLException implements Exception {
  final String message;
  final OperationException? originalException;

  GraphQLException(this.message, {this.originalException});

  @override
  String toString() => message;
}

class GraphQLNetworkException extends GraphQLException {
  GraphQLNetworkException(super.message, {super.originalException});
}

class GraphQLAuthException extends GraphQLException {
  GraphQLAuthException(super.message, {super.originalException});
}

class GraphQLValidationException extends GraphQLException {
  final Map<String, dynamic>? validationErrors;

  GraphQLValidationException(
    super.message, {
    this.validationErrors,
    super.originalException,
  });
}

class GraphQLOperationException extends GraphQLException {
  final List<GraphQLError>? errors;

  GraphQLOperationException(
    super.message, {
    this.errors,
    super.originalException,
  });
}
