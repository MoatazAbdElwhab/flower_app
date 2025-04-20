import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/core/app_data/api/api_constants.dart';
import 'package:flower_app/features/checkout/data/datasources/remote/checkout_remote_data_source.dart';
import 'package:flower_app/features/checkout/data/models/addresses_response/address_model.dart';
import 'package:flower_app/features/checkout/data/models/addresses_response/addresses_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRemoteDataSource)
class CheckoutApiRemoteDataSource implements CheckoutRemoteDataSource {
  final ApiClient apiClient;
  CheckoutApiRemoteDataSource(this.apiClient);

  @override
  Future<List<AddressModel>> getAddresses() async {
    final response = await apiClient.get(
      ApiConstants.addressesEndPoint,
    );
    return AddressesResponse.fromJson(response).addresses;
  }
}
