import '../../../../occasion/data/models/occasion_response/product_model.dart';

abstract class CategoriesRemoteDataSourceContract {
  Future<List<ProductModel>> getSortedProducts(
      String categoryId, String sortOption);

  Future<List<ProductModel>> getCategories(String categoryId);
}
