// lib/features/profile/domain/entities/order.dart
import 'package:flower_app/features/profile/data/models/get_user_oreders_response/user_orders_response.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/order_items_entity.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/user_products_entity.dart';

class UserOrdersEntitiy {
  final String? id; 
  final OrderItemsEntity orderItem;
  final int? totalPrice;
  final String? state; 

  UserOrdersEntitiy({
    required this.id,
    required this.orderItem,
    required this.totalPrice,
    required this.state,
  });
}

List<UserOrdersEntitiy> toEntity(UserOrdersResponse response) {
  return response.orders?.map((order) {
    // check if orderItems is not empty
    final firstItem = order.orderItems?.isNotEmpty == true ? order.orderItems![0] : null;
    return UserOrdersEntitiy(
      id: order.orderNumber ?? '',
      orderItem: OrderItemsEntity(
        product: UserProductsEntity(
          title: firstItem?.product?.title ?? '',
          imgCover: firstItem?.product?.imgCover ?? '',
        ),
        price: firstItem?.price ?? 0,
      ),
      totalPrice: order.totalPrice ?? 0,
      state: order.state ?? 'unknown',
    );
  }).toList() ?? [];
}