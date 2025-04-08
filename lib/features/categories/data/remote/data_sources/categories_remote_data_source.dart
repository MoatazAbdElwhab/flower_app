import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';

abstract class CategoriesRemoteDataSourceContract {
Future<CategoryProductsModel> getCategories(String categoryId);
}