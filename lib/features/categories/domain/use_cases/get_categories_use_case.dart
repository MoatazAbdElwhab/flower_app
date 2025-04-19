import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';
import 'package:flower_app/features/categories/domain/repositories/categories_repo.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  final CategoriesRepo _repo;

  GetCategoriesUseCase(this._repo);

  Future<Either<ApiException, List<ProductEntity>>> call(String categoryId) async =>
      await _repo.getCategories(categoryId);
}
