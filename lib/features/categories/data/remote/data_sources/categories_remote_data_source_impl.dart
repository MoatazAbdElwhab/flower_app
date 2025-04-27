// features/categories/data/remote/data_sources/categories_remote_data_source_impl.dart
import 'package:flower_app/core/app_data/api/graphql/graphql_client.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../../../../occasion/data/models/occasion_response/product_model.dart';
import 'categories_remote_data_source.dart';

@Injectable(as: CategoriesRemoteDataSourceContract)
class CategoriesRemoteDataSourceImpl
    implements CategoriesRemoteDataSourceContract {
  final GraphQLClient _graphQLClient;
  final Logger _logger;

  CategoriesRemoteDataSourceImpl(this._graphQLClient, this._logger);

  /// Factory constructor for dependency injection
  @factoryMethod
  static CategoriesRemoteDataSourceContract create(GraphQLClient client) {
    return CategoriesRemoteDataSourceImpl(client, Logger());
  }

  @override
  Future<List<ProductModel>> getCategories(String categoryId) async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql('''
          query GetProductsByCategory(\$categoryId: ID!) {
            productsByCategory(categoryId: \$categoryId) {
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
          'categoryId': categoryId,
        },
      );

      final result = await _graphQLClient.query(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception('Failed to get products by category: ${result.exception.toString()}');
      }

      final data = result.data?['productsByCategory']?['products'];
      if (data == null) {
        return [];
      }

      return List<ProductModel>.from(
          data.map((product) => ProductModel.fromJson(product)));
    } catch (e) {
      _logger.e('Error getting products by category: $e');
      throw Exception('Failed to get products by category: $e');
    }
  }

  @override
  Future<List<ProductModel>> getSortedProducts(
      String categoryId, String sortOption) async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql('''
          query GetSortedProductsByCategory(\$categoryId: ID!, \$sortOption: String!) {
            productsByCategory(categoryId: \$categoryId, sort: \$sortOption) {
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
          'categoryId': categoryId,
          'sortOption': sortOption,
        },
      );

      final result = await _graphQLClient.query(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception('Failed to get sorted products: ${result.exception.toString()}');
      }

      final data = result.data?['productsByCategory']?['products'];
      if (data == null) {
        return [];
      }

      return List<ProductModel>.from(
          data.map((product) => ProductModel.fromJson(product)));
    } catch (e) {
      _logger.e('Error getting sorted products: $e');
      throw Exception('Failed to get sorted products: $e');
    }
  }
}
