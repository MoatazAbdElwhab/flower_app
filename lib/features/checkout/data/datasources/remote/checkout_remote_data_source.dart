import 'package:flower_app/features/checkout/data/models/addresses_response/address_model.dart';
import 'package:flower_app/features/checkout/data/models/check_out_requset.dart';
import 'package:flower_app/features/checkout/data/models/payment_success_response.dart';

abstract class CheckoutRemoteDataSource {
  Future<List<AddressModel>> getAddresses();
  Future<PaymentSuccessResponse> createCheckoutSession(
      CheckOutRequest checkOutRequest);
}
