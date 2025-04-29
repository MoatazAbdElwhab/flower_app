import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/core/app_data/api/api_constants.dart';
import 'package:flower_app/features/occasion/data/datasources/remote/occasion_remote_data_source.dart';
import 'package:flower_app/features/occasion/data/models/occasion_response/occasion_response.dart';
import 'package:flower_app/features/occasion/data/models/occasion_response/product_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OccasionRemoteDataSource)
class OccasionApiRemoteDataSource extends OccasionRemoteDataSource {
  final ApiClient _apiClient;

  OccasionApiRemoteDataSource(this._apiClient);

  @override
  Future<List<ProductModel>> getOccasionsById(String id) async {
    final response = await _apiClient.get(
      ApiConstants.occasionsEndPoint,
      queryParameters: {
        'occasion': id,
      },
    );
    return OccasionResponse.fromJson(response).products ?? [];
  }
}
