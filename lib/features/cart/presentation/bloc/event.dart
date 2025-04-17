import 'package:equatable/equatable.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartLoadEvent extends CartEvent {
  const CartLoadEvent();
}

class CartAddProductEvent extends CartEvent {
  final ProductEntity product;

  const CartAddProductEvent({
    required this.product,
  });

  @override
  List<Object?> get props => [product];
}

class CartRemoveProductEvent extends CartEvent {
  final String productId;

  const CartRemoveProductEvent({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class CartClearEvent extends CartEvent {
  const CartClearEvent();
}

class CartUpdateProductQuantityEvent extends CartEvent {
  final String productId;
  final int quantity;
  const CartUpdateProductQuantityEvent(
      {required this.productId, required this.quantity});
  @override
  List<Object?> get props => [productId, quantity];
}
