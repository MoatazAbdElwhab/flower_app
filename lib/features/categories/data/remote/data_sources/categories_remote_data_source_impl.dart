import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/app_data/api/api_constants.dart';
import 'categories_remote_data_source.dart';

@Injectable(as: CategoriesRemoteDataSourceContract)
class CategoriesRemoteDataSourceImpl
    implements CategoriesRemoteDataSourceContract {
  final ApiClient _apiClient;

  CategoriesRemoteDataSourceImpl(this._apiClient);

  @override
  Future<CategoryProductsModel> getCategories(String categoryId) async {
    const categoryEndpoint = ApiConstants.getProudctByCategoryEndPoint;

    final response = await _apiClient
        .get(categoryEndpoint, requiresToken: false, queryParameters: {
      'category': categoryId,
    });

    return CategoryProductsModel.fromJson(response);
  }
}
