import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/categories/domain/repositories/categories_repo.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSortedProductsUseCase {
  final CategoriesRepo _repo;

  GetSortedProductsUseCase(this._repo);

  Future<Either<ApiException, List<ProductEntity>>> call(
    String categoryId,
    String sortOption,
  ) async =>
      await _repo.getSortedProducts(categoryId, sortOption);
}
