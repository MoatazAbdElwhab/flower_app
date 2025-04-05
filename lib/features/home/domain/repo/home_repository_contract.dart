// features/home/domain/repo/home_repository_contract.dart

import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/home/domain/entities/home_entity.dart';

abstract class HomeRepositoryContract {
  Future<Either<ApiException, HomeEntity>> getHomeData();
}
