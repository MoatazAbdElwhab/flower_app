import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';

abstract class CategoriesRepo {
  Future<Either<ApiException, List<ProductEntity>>> getSortedProducts(
      String categoryId, String sortOption);

  Future<Either<ApiException, List<ProductEntity>>> getCategories(
      String categoryId);
}
