// features/home/domain/use_case/home_use_case.dart

import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/home/domain/entities/home_entity.dart';
import 'package:flower_app/features/home/domain/repo/home_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeDataUseCase {
  final HomeRepositoryContract _homeRepository;

  GetHomeDataUseCase(this._homeRepository);

  Future<Either<ApiException, HomeEntity>> call() {
    return _homeRepository.getHomeData();
  }
}
