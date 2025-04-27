// features/search/data/datasources/search_remote_ds_impl.dart
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'search_remote_ds_interface.dart';

@Injectable(as: SearchRemoteDsInterface)
class SearchRemoteDsImpl implements SearchRemoteDsInterface {
  final GraphQLClient _graphQLClient;
  final Logger _logger;
  
  SearchRemoteDsImpl(this._graphQLClient, this._logger);

  @factoryMethod
  static SearchRemoteDsInterface create(GraphQLClient client) {
    return SearchRemoteDsImpl(client, Logger());
  }

  @override
  Future<List<Products>> searchProducts(String query, {String? categoryId}) async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql('''
          query SearchProducts(\$keyword: String!, \$category: ID) {
            searchProducts(keyword: \$keyword, category: \$category) {
              message
              metadata {
                currentPage
                totalPages
                limit
                totalItems
              }
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
                __v
                discount
                sold
                rateAvg
                rateCount
                id
              }
            }
          }
        '''),
        variables: <String, dynamic>{
          'keyword': query,
          if (categoryId != null && categoryId.isNotEmpty) 'category': categoryId,
        },
        fetchPolicy: FetchPolicy.networkOnly,
      );

      final result = await _graphQLClient.query(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw ApiException(message: 'Failed to search products: ${result.exception.toString()}');
      }

      final data = result.data?['searchProducts'];
      if (data == null) {
        throw ApiException(message: 'API returned no search results');
      }

      final productsJson = data['products'] as List<dynamic>?;
      if (productsJson == null || productsJson.isEmpty) {
        return [];
      }

      return productsJson.map((product) => Products.fromJson(product)).toList();
    } catch (e) {
      _logger.e('Error searching products: $e');
      if (e is ApiException) {
        throw e;
      }
      throw ApiException(message: 'Failed to search products: $e');
    }
  }
}
