/// Constants used for GraphQL configuration and operations
class GraphQLConstants {
  /// Base GraphQL API endpoint
  static const String endpoint = 'http://localhost:4000/graphql';
  
  /// Operation timeout in seconds
  static const int operationTimeout = 30;
  
  /// Cache options
  static const bool enableOfflineCache = true;
  static const int maxCacheSizeInMB = 100;
  
  /// Error codes
  static const String authErrorCode = 'UNAUTHENTICATED';
  static const String networkErrorCode = 'NETWORK_ERROR';
  static const String validationErrorCode = 'VALIDATION_ERROR';
  
  /// Operation types
  static const String queryOperation = 'query';
  static const String mutationOperation = 'mutation';
  static const String subscriptionOperation = 'subscription';
  
  /// Headers
  static const String authHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String contentTypeValue = 'application/json';
}
