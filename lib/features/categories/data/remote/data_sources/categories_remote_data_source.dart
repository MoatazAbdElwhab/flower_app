import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';

import '../../../../occasion/data/models/occasion_response/product_model.dart';

abstract class CategoriesRemoteDataSourceContract {

  Future<CategoryProductsModel> getSortedProducts(
      String categoryId, String sortOption);

  Future<List<ProductModel>> getCategories(String categoryId);

}
