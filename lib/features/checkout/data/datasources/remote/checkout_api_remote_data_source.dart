import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/core/app_data/api/api_constants.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/checkout/data/datasources/remote/checkout_remote_data_source.dart';
import 'package:flower_app/features/checkout/data/models/addresses_response/address_model.dart';
import 'package:flower_app/features/checkout/data/models/addresses_response/addresses_response.dart';
import 'package:flower_app/features/checkout/data/models/check_out_requset.dart';
import 'package:flower_app/features/checkout/data/models/check_out_session_response/check_out_session_response.dart';
import 'package:flower_app/features/checkout/data/models/create_cash_order_response/create_cash_order_response.dart';
import 'package:flower_app/features/checkout/data/models/payment_success_response.dart';
import 'package:flower_app/features/checkout/payment_type/payment_types.dart';
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

  @override
  Future<PaymentSuccessResponse> createCheckoutSession(
      CheckOutRequest checkOutRequest) async {
    switch (checkOutRequest.paymentMethod) {
      case PaymentMethodsType.card:
        return _createCheckoutSession(checkOutRequest);
      case PaymentMethodsType.cash:
        return _createCashOrder(checkOutRequest);
      default:
        throw ApiException(message: 'Unknown payment method');
    }
  }

  Future<CreateCashOrderResponse> _createCashOrder(
      CheckOutRequest checkOutRequest) async {
    final response = await apiClient.post(
      ApiConstants.checkoutSessionCashEndPoint,
      data: checkOutRequest.toJson(),
      requiresToken: true,
    );
    return CreateCashOrderResponse.fromJson(response);
  }

  Future<CheckOutSessionResponse> _createCheckoutSession(
      CheckOutRequest checkOutRequest) async {
    final response = await apiClient.post(
      ApiConstants.checkoutSessionEndPoint,
      data: checkOutRequest.toJson(),
      requiresToken: true,
    );
    return CheckOutSessionResponse.fromJson(response);
  }
}
