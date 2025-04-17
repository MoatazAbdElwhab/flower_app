// features/search/data/datasources/search_remote_ds_impl.dart
import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/core/app_data/api/api_constants.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';
import 'package:injectable/injectable.dart';
import 'search_remote_ds_interface.dart';

@Injectable(as: SearchRemoteDsInterface)
class SearchRemoteDsImpl implements SearchRemoteDsInterface {
  final ApiClient _apiClient;
  
  SearchRemoteDsImpl(this._apiClient);

  @override
  Future<List<Products>> searchProducts(String query, {String? categoryId}) async {
    Map<String, dynamic> queryParams = {'keyword': query};
    if (categoryId != null && categoryId.isNotEmpty) {
      queryParams['category'] = categoryId;
    }

    final response = await _apiClient.get(
      ApiConstants.getProudctByCategoryEndPoint,
      queryParameters: queryParams,
      requiresToken: false,
    );

    if (response['message'] == 'success') {
      final CategoryProductsModel data = CategoryProductsModel.fromJson(response);
      if (data.products == null) {
        throw ApiException(message: 'API returned success but products data is missing');
      }
      return data.products!;
    } else {
      throw ApiException(message: 'Failed to search products: ${response['message'] ?? 'Unknown error'}');
    }
  }
}
