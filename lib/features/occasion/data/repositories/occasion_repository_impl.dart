import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/occasion/data/datasources/remote/occasion_remote_data_source.dart';
import 'package:flower_app/features/occasion/domain/repositories/occasion_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OccasionRepository)
class OccasionRepositoryImpl extends OccasionRepository {
  final OccasionRemoteDataSource _occasionRemoteDataSource;

  OccasionRepositoryImpl(this._occasionRemoteDataSource);

  @override
  Future<Either<Exception, List<ProductEntity>>> getOccasionsById(
      String id) async {
    try {
      final response = await _occasionRemoteDataSource.getOccasionsById(id);
      return Right(response.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}
