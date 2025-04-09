import 'package:flower_app/features/occasion/data/models/occasion_response/product_model.dart';
import 'package:either_dart/either.dart';

abstract class OccasionRemoteDataSource {
  Future<List<ProductModel>> getOccasionsById(String id);
}
