import 'package:flower_app/features/checkout/data/models/addresses_response/address_model.dart';

abstract class CheckoutRemoteDataSource {
  Future<List<AddressModel>> getAddresses();
}
