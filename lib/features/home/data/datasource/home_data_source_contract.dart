// features/home/data/datasource/home_data_source_contract.dart

import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/home/data/model/response/home/home.dart';

abstract class HomeDataSourceContract {
  Future<Either<ApiException, Home>> getHomeData();
}
