import 'package:flower_app/features/cart/data/models/get_cart_response.dart';

abstract class CartRemoteDsInterface {
  Future<void> addProductToCart(String productId);
  Future<void> removeProductFromCart(String productId);
  Future<void> clearCart();
  Future<void> updateProductQuantity(String productId, int quantity);
  Future<GetCartResponse> getUserCart();
}