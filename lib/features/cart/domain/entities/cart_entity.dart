import 'package:flower_app/features/cart/data/models/CartDm.dart';
import 'package:flower_app/features/cart/data/models/cart_item.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';

class CartEntity {
  final List<ProductEntity> products;
  final num discount;
  final num totalPrice;
  final num totalPriceAfterDiscount;

  CartEntity({
    required this.products,
    required this.discount,
    required this.totalPrice,
    required this.totalPriceAfterDiscount,
  });

  CartEntity.fromCartDm(CartDm cart)
      : discount = cart.discount ?? 0,
        totalPrice = cart.totalPrice ?? 0,
        totalPriceAfterDiscount = cart.totalPriceAfterDiscount ?? 0,
        products = [] {
    if (cart.cartItems != null && cart.cartItems!.isNotEmpty) {
      for (CartItem item in cart.cartItems!) {
        if (item.product != null) {
          products.add(item.product!.toEntity());
        }
      }
    }
  }
}
