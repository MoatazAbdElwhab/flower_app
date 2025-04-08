import 'package:dartz/dartz.dart';
import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';
import 'package:flower_app/features/home/data/model/response/home/product.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error_handling/exceptions/api_exception.dart';
import '../../domain/repositories/categories_repo.dart';
import '../remote/data_sources/categories_remote_data_source.dart';

@Injectable(as: CategoriesRepo)
class CategoriesRepoImpl implements CategoriesRepo {
  final CategoriesRemoteDataSourceContract _categoriesData;

  CategoriesRepoImpl(this._categoriesData);

  @override
  Future<Either<ApiException, List<Products>>> getCategories(
      String categoryId) async {
    try {
      var response = await _categoriesData.getCategories(categoryId);
      if (response.products != null) {
        return Right((response.products ?? []));
      } else {
        return Left(ApiException(message: 'No Proudct found'));
      }
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}
