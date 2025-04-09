import 'package:either_dart/either.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';

abstract class OccasionRepository {
  Future<Either<Exception, List<ProductEntity>>> getOccasionsById(String id);
}
