// lib/features/profile/domain/entities/order_item.dart
import 'package:flower_app/features/profile/domain/entities/user_orders/user_products_entity.dart';

class OrderItemsEntity {
  final UserProductsEntity product; 
  final int price; 

  OrderItemsEntity({
    required this.product,
    required this.price,
  });
}