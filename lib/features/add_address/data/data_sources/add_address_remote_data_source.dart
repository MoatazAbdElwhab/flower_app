


import '../models/add_adress_model/add_adress_request.dart';

abstract class AddAddressRemoteDataSource {
  Future<void> addAddress(AddAdressRequest addAdressRequest);
}