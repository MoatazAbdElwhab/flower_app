// features/home/data/datasource/home_data_source_impl.dart

import 'package:either_dart/src/either.dart';
import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/core/app_data/api/api_constants.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:flower_app/features/home/data/datasource/home_data_source_contract.dart';
import 'package:flower_app/features/home/data/model/response/home/home.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeDataSourceContract)
class HomeDataSourceImpl implements HomeDataSourceContract {
  final ApiClient _apiClient;

  HomeDataSourceImpl(this._apiClient);

  @override
  Future<Either<ApiException, Home>> getHomeData() async {
    try {
      final response = await _apiClient.get(
        ApiConstants.homeEndPoint,
        requiresToken: true,
      );

      final homeResponse = Home.fromJson(response);
      return Right(homeResponse);
    } catch (e) {
      Log.e('Error fetching home data: $e');
      return Left(ApiException(message: 'Failed to fetch home data: $e'));
    }
  }
}
