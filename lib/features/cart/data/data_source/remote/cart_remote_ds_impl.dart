import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/features/cart/data/models/get_cart_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/app_data/api/api_constants.dart';
import 'cart_remote_ds_interface.dart';

@Injectable(as: CartRemoteDsInterface)
class CartRemoteDsImpl implements CartRemoteDsInterface {
  final ApiClient _apiClient;
  CartRemoteDsImpl(this._apiClient);

  @override
  Future<GetCartResponse> getUserCart() async {
    final apiResponse =
        await _apiClient.get(ApiConstants.cart, requiresToken: true);
    final cartResponse = GetCartResponse.fromJson(apiResponse);
    return cartResponse;
  }

  @override
  Future<void> addProductToCart(String productId) async {
    await _apiClient.post(ApiConstants.cart,
        requiresToken: true, data: {'product': productId, 'quantity': 1});
  }

  @override
  Future<void> clearCart() async {
    await _apiClient.delete(ApiConstants.cart, requiresToken: true);
  }

  @override
  Future<void> removeProductFromCart(String productId) async {
    await _apiClient.delete('${ApiConstants.cart}/$productId',
        requiresToken: true);
  }

  @override
  Future<void> updateProductQuantity(String productId, int quantity) async {
    await _apiClient.put('${ApiConstants.cart}/$productId',
        data: {'quantity': quantity}, requiresToken: true);
  }
}
