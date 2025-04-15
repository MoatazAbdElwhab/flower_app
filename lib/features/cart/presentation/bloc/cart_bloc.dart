import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/features/cart/domain/use_cases/cart_add_product_use_case.dart';
import 'package:flower_app/features/cart/domain/use_cases/cart_load_use_case.dart';
import 'package:flower_app/features/cart/domain/use_cases/cart_remove_product_use_case.dart';
import 'package:flower_app/features/cart/domain/use_cases/clear_cart_use_case.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/base/base_state.dart';
import '../../domain/use_cases/update_product_quantity_use_case.dart';
import 'cart_state.dart';
import 'event.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartLoadUseCase _loadCartUseCase;
  final CartAddProductUseCase _addProductUseCase;
  final CartRemoveProductUseCase _removeProductUseCase;
  final ClearCartUseCase _clearCartUseCase;
  final CartUpdateProductQuantityUseCase _updateQuantityUseCase;

  CartBloc(
      this._clearCartUseCase,
      this._addProductUseCase,
      this._loadCartUseCase,
      this._removeProductUseCase,
      this._updateQuantityUseCase)
      : super(const CartState()) {
    on<CartLoadEvent>(_onLoadCart);
    on<CartAddProductEvent>(_onAddProduct);
    on<CartRemoveProductEvent>(_onRemoveProduct);
    on<CartClearEvent>(_onClearCart);
    on<CartUpdateProductQuantityEvent>((_onUpdateProductQuantity),
        transformer: (events, mapper) =>
            events.debounceTime(const Duration(seconds: 1)).switchMap(mapper));
    add(const CartLoadEvent());
  }

  Future<void> _onLoadCart(CartLoadEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(getCartState: BaseLoadingState()));
    try {
      final apiResponse = await _loadCartUseCase();
      if (apiResponse.cart == null ||
          apiResponse.cart!.cartItems == null ||
          apiResponse.cart!.totalPrice == null) {
        emit(state.copyWith(
            getCartState:
                BaseErrorState(LocaleKeys.cart_failedToGetCart.tr())));
        return;
      }
      final cartItems = apiResponse.cart!.cartItems;
      List<ProductEntity> cartProducts =
          cartItems!.map((e) => e.product!.toEntity()).toList();
      emit(state.copyWith(
          getCartState: BaseSuccessState(),
          cartProducts: cartProducts,
          cartTotalPrice: _getCartTotalPrice(cartProducts)));
    } catch (e) {
      emit(state.copyWith(getCartState: BaseErrorState(e.toString())));
    }
  }

  Future<void> _onAddProduct(
      CartAddProductEvent event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(
          addToCartState: BaseLoadingState(),
          activeCartItemId: event.product.id));
      await _addProductUseCase(event.product.id);
      final updatedList = state.cartProducts;
      updatedList?.add(event.product..cartQuantity = 1);
      emit(state.copyWith(
        cartTotalPrice: _getCartTotalPrice(updatedList ?? []),
        addToCartState: BaseSuccessState(),
        cartProducts: updatedList,
      ));
    } catch (e) {
      emit(state.copyWith(addToCartState: BaseErrorState(e.toString())));
    }
  }

  Future<void> _onRemoveProduct(
      CartRemoveProductEvent event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(
          removeFromCartState: BaseLoadingState(),
          activeCartItemId: event.productId));
      await _removeProductUseCase(event.productId);
      final newCartList = state.cartProducts
        ?..removeWhere(
          (element) => element.id == event.productId,
        );
      emit(state.copyWith(
          removeFromCartState: BaseSuccessState(),
          cartProducts: newCartList ?? [],
          cartTotalPrice: _getCartTotalPrice(newCartList ?? [])));
    } catch (e) {
      emit(state.copyWith(removeFromCartState: BaseErrorState(e.toString())));
    }
  }

  Future<void> _onClearCart(
      CartClearEvent event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(clearCartState: BaseLoadingState()));
      await _clearCartUseCase();
      emit(state.copyWith(
          clearCartState: BaseSuccessState(), cartTotalPrice: 0));
    } catch (e) {
      emit(state.copyWith(clearCartState: BaseErrorState(e.toString())));
    }
  }

  Future<void> _onUpdateProductQuantity(
      CartUpdateProductQuantityEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(
        updateQuantityState: BaseLoadingState(),
        activeCartItemId: event.productId));
    try {
      await _updateQuantityUseCase(event.productId, event.quantity);
      final updatedList = state.cartProducts
        ?..firstWhere(
          (p) => p.id == event.productId,
        ).cartQuantity = event.quantity;
      emit(state.copyWith(
          updateQuantityState: BaseSuccessState(),
          cartProducts: updatedList,
          cartTotalPrice: _getCartTotalPrice(updatedList ?? []),
          activeCartItemId: event.productId));
      Future.delayed(
        const Duration(milliseconds: 30),
        () {
          /// to remove active cart item after it's listened to
          emit(state.copyWith());
        },
      );
    } catch (e) {
      emit(state.copyWith(updateQuantityState: BaseErrorState(e.toString())));
    }
  }

  num _getCartTotalPrice(List<ProductEntity> prods) {
    if (prods.isEmpty) return 0;
    return state.deliveryFee +
        prods.map((e) => e.totalPrice ?? 0).fold(0, (a, b) => a + b);
  }
}
