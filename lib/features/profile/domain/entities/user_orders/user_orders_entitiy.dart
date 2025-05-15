// lib/features/profile/domain/entities/order.dart
import 'package:flower_app/features/profile/data/models/get_user_oreders_response/user_orders_response.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/order_items_entity.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/user_products_entity.dart';

class UserOrdersEntitiy {
  final List<Orders> orders;

  UserOrdersEntitiy({required this.orders});
}

UserOrdersEntitiy toEntity(UserOrdersResponse response) {
  return UserOrdersEntitiy(orders: response.orders ?? []);
}
