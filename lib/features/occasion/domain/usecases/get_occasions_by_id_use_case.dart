import 'package:either_dart/either.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/occasion/domain/repositories/occasion_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOccasionsByIdUseCase {
  final OccasionRepository _occasionRepository;

  GetOccasionsByIdUseCase(this._occasionRepository);

  Future<Either<Exception, List<ProductEntity>>> call(String id) async {
    return _occasionRepository.getOccasionsById(id);
  }
}
