import 'package:injectable/injectable.dart';

import '../../../../core/app_data/api/api_client.dart';
import '../../../../core/app_data/api/api_constants.dart';
import '../models/add_adress_model/add_adress_request.dart';
import 'add_address_remote_data_source.dart';
@Injectable(as: AddAddressRemoteDataSource)
class AddAddressRemoteDataSourceImpl implements AddAddressRemoteDataSource{
  final ApiClient _apiClient;

  AddAddressRemoteDataSourceImpl(this._apiClient);
  @override
  Future<void> addAddress(AddAndEditAddressRequest addAdressRequest) async {
    await _apiClient.patch(
      ApiConstants.addressesEndPoint,
      data: addAdressRequest.toJson(),
      requiresToken: true,
    );
  }
}