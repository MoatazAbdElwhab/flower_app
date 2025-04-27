// features/home/data/datasource/home_data_source_impl.dart

import 'package:either_dart/src/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/home/data/datasource/home_data_source_contract.dart';
import 'package:flower_app/features/home/data/model/response/home/home.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: HomeDataSourceContract)
class HomeDataSourceImpl implements HomeDataSourceContract {
  final GraphQLClient _graphQLClient;
  final Logger _logger;

  HomeDataSourceImpl(this._graphQLClient, this._logger);

  @factoryMethod
  static HomeDataSourceContract create(GraphQLClient client) {
    return HomeDataSourceImpl(client, Logger());
  }

  @override
  Future<Either<ApiException, Home>> getHomeData() async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql('''
          query GetHomeData {
            homeData {
              message
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
                category {
                  _id
                  name
                  image
                }
                ratingsAverage
                sold
                discount
              }
              categories {
                _id
                name
                image
                createdAt
                updatedAt
              }
              bestSeller {
                _id
                title
                slug
                description
                imgCover
                images
                price
                priceAfterDiscount
                quantity
                category {
                  _id
                  name
                  image
                }
                ratingsAverage
                sold
                discount
              }
              occasions {
                _id
                name
                image
                createdAt
                updatedAt
              }
            }
          }
        '''),
        fetchPolicy: FetchPolicy.networkOnly,
      );

      final result = await _graphQLClient.query(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        return Left(ApiException(message: 'Failed to fetch home data: ${result.exception.toString()}'));
      }

      final data = result.data?['homeData'];
      if (data == null) {
        return Left(ApiException(message: 'No home data returned from server'));
      }

      final homeResponse = Home.fromJson(data);
      return Right(homeResponse);
    } catch (e) {
      _logger.e('Error fetching home data: $e');
      return Left(ApiException(message: 'Failed to fetch home data: $e'));
    }
  }
}
