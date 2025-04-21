import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/categories/domain/repositories/categories_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../home/domain/entities/product_entity.dart';

@injectable
class GetCategoriesUseCase {
  final CategoriesRepo _repo;

  GetCategoriesUseCase(this._repo);

  Future<Either<ApiException, List<ProductEntity>>> call(String categoryId) async =>
      await _repo.getCategories(categoryId);
}
