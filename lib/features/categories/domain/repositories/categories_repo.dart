import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';

abstract class CategoriesRepo {

  Future<Either<ApiException, List<Products>>> getSortedProducts(
      String categoryId, String sortOption);

  Future<Either<ApiException, List<ProductEntity>>> getCategories(String categoryId);

}
