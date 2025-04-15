import 'package:flower_app/features/cart/data/models/get_cart_response.dart';
import 'package:flower_app/features/cart/domain/repo/cart_repo_interface.dart';
import 'package:injectable/injectable.dart';

import '../data_source/remote/cart_remote_ds_interface.dart';

@Injectable(as: CartRepoInterface)
class CartRepoImpl implements CartRepoInterface {
  final CartRemoteDsInterface cartRemoteDsInterface;
  CartRepoImpl(this.cartRemoteDsInterface);
  @override
  Future<void> addProductToCart(String productId) async {
    await cartRemoteDsInterface.addProductToCart(productId);
  }

  @override
  Future<void> clearCart() async {
    await cartRemoteDsInterface.clearCart();
  }

  @override
  Future<GetCartResponse> getUserCart() async {
    return await cartRemoteDsInterface.getUserCart();
  }

  @override
  Future<void> removeProductFromCart(String productId) async {
    await cartRemoteDsInterface.removeProductFromCart(productId);
  }

  @override
  Future<void> updateProductQuantity(String productId, int quantity) async {
    await cartRemoteDsInterface.updateProductQuantity(productId, quantity);
  }
}
