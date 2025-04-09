import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';

abstract class CategoriesRepo {
  Future<Either<ApiException, List<Products>>> getCategories(
      String categoryId);
}
