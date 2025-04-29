import 'package:either_dart/either.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error_handling/exceptions/api_exception.dart';
import '../../domain/repositories/categories_repo.dart';
import '../remote/data_sources/categories_remote_data_source.dart';

@Injectable(as: CategoriesRepo)
class CategoriesRepoImpl implements CategoriesRepo {
  final CategoriesRemoteDataSourceContract _categoriesData;

  CategoriesRepoImpl(this._categoriesData);

  @override
  Future<Either<ApiException, List<ProductEntity>>> getCategories(
      String categoryId) async {
    try {
      var response = await _categoriesData.getCategories(categoryId);
      return Right(response.map((e) => e.toEntity()).toList());
        } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, List<ProductEntity>>> getSortedProducts(
      String categoryId, String sortOption) async {
    try {
      var response =
          await _categoriesData.getSortedProducts(categoryId, sortOption);
      return Right(response.map((e) => e.toEntity()).toList());
        } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}
