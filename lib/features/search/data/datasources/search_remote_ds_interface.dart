import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';

abstract class SearchRemoteDsInterface {
  Future<List<Products>> searchProducts(String query, {String? categoryId});
}
