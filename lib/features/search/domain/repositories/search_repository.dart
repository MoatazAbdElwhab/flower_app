import 'package:flower_app/features/home/domain/entities/product_entity.dart';

abstract class SearchRepository {
  Future<List<ProductEntity>> searchProducts(String query, {String? categoryId});
}
