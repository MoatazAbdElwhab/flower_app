import 'package:equatable/equatable.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import '../../../../core/base/base_state.dart';

class CartState extends Equatable {
  final List<ProductEntity>? cartProducts;
  final BaseState? getCartState;
  final BaseState? addToCartState;
  final BaseState? removeFromCartState;
  final BaseState? clearCartState;
  final BaseState? updateQuantityState;
  final String? activeCartItemId;
  final num cartTotalPrice;
  final num deliveryFee;
  const CartState({
    this.cartProducts,
    this.updateQuantityState,
    this.getCartState,
    this.addToCartState,
    this.removeFromCartState,
    this.clearCartState,
    this.activeCartItemId,
    this.deliveryFee = 20,
    this.cartTotalPrice = 0,
  });

  CartState copyWith({
    List<ProductEntity>? cartProducts,
    BaseState? getCartState,
    BaseState? addToCartState,
    BaseState? removeFromCartState,
    BaseState? clearCartState,
    BaseState? updateQuantityState,
    String? activeCartItemId,
    num? deliveryFee,
    num? cartTotalPrice,
  }) {
    return CartState(
      cartProducts: cartProducts ?? this.cartProducts,
      getCartState: getCartState ?? this.getCartState,
      addToCartState: addToCartState ?? this.addToCartState,
      removeFromCartState: removeFromCartState ?? this.removeFromCartState,
      clearCartState: clearCartState ?? this.clearCartState,
      updateQuantityState: updateQuantityState ?? this.updateQuantityState,
      activeCartItemId: activeCartItemId,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      cartTotalPrice: cartTotalPrice ?? this.cartTotalPrice,
    );
  }

  @override
  List<Object?> get props => [
        getCartState,
        addToCartState,
        removeFromCartState,
        updateQuantityState,
        clearCartState,
        cartProducts,
        activeCartItemId,
        cartTotalPrice,
        deliveryFee
      ];
}
