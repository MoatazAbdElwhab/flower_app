// features/occasion/data/datasources/remote/occasion_api_remote_data_source.dart
import 'package:flower_app/features/occasion/data/datasources/remote/occasion_remote_data_source.dart';
import 'package:flower_app/features/occasion/data/models/occasion_response/product_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: OccasionRemoteDataSource)
class OccasionApiRemoteDataSource implements OccasionRemoteDataSource {
  final GraphQLClient _graphQLClient;
  final Logger _logger;

  OccasionApiRemoteDataSource(this._graphQLClient, this._logger);

  @factoryMethod
  static OccasionRemoteDataSource create(GraphQLClient client) {
    return OccasionApiRemoteDataSource(client, Logger());
  }

  @override
  Future<List<ProductModel>> getOccasionsById(String id) async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql('''
          query GetProductsByOccasion(\$occasionId: ID!) {
            productsByOccasion(occasionId: \$occasionId) {
              products {
                _id
                title
                slug
                description
                imgCover
                images
                price
                priceAfterDiscount
                quantity
                category
                occasion
                createdAt
                updatedAt
                __v
                discount
                sold
                rateAvg
                rateCount
              }
            }
          }
        '''),
        variables: <String, dynamic>{
          'occasionId': id,
        },
      );

      final result = await _graphQLClient.query(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception('Failed to get products by occasion: ${result.exception.toString()}');
      }

      final data = result.data?['productsByOccasion']?['products'];
      if (data == null) {
        return [];
      }

      return List<ProductModel>.from(
          data.map((product) => ProductModel.fromJson(product)));
    } catch (e) {
      _logger.e('Error getting products by occasion: $e');
      return [];
    }
  }
}
