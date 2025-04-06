// features/home/data/repo/home_repository_impl.dart

import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/home/data/datasource/home_data_source_contract.dart';
import 'package:flower_app/features/home/domain/entities/home_entity.dart';
import 'package:flower_app/features/home/domain/repo/home_repository_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepositoryContract)
class HomeRepositoryImpl implements HomeRepositoryContract {
  final HomeDataSourceContract _homeDataSource;

  HomeRepositoryImpl(this._homeDataSource);

  @override
  Future<Either<ApiException, HomeEntity>> getHomeData() async {
    final result = await _homeDataSource.getHomeData();
    return result.map((homeModel) => HomeEntity.fromModel(homeModel));
  }
}
