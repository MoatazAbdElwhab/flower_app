import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';
import 'package:flower_app/features/occasion/data/models/occasion_response/occasion_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/app_data/api/api_constants.dart';
import '../../../../occasion/data/models/occasion_response/product_model.dart';
import 'categories_remote_data_source.dart';

@Injectable(as: CategoriesRemoteDataSourceContract)
class CategoriesRemoteDataSourceImpl
    implements CategoriesRemoteDataSourceContract {
  final ApiClient _apiClient;

  CategoriesRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<ProductModel>> getCategories(String categoryId) async {
    const categoryEndpoint = ApiConstants.getProudctByCategoryEndPoint;

    final response = await _apiClient
        .get(categoryEndpoint, requiresToken: false, queryParameters: {
      'category': categoryId,
    });

    return OccasionResponse.fromJson(response).products ?? [];
  }

  @override
  Future<List<ProductModel>> getSortedProducts(
      String categoryId, String sortOption) async {
    const categoryEndpoint = ApiConstants.getProudctByCategoryEndPoint;

    final response = await _apiClient
        .get(categoryEndpoint, requiresToken: false, queryParameters: {
      'category': categoryId,
      'sort': sortOption,
    });

    return OccasionResponse.fromJson(response).products ?? [];
  }
}
