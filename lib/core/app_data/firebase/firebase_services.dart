import 'package:firebase_database/firebase_database.dart';
import 'package:flower_app/core/sharedModels/fire_base_order_model.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/user_orders_entitiy.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseService {
  FirebaseService();
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  DatabaseReference get _ordersRef => _database.ref('orders');
  DatabaseReference get _usersRef => _database.ref('users');

  Future<void> sendOrderToFirebase(dynamic order) async {
    try {
      if (order.state?.toLowerCase() == 'canceled') return;

      final String orderId = order.id ?? order._id ?? '';
      final String userId = order.user?._id ?? order.user ?? '';

      if (orderId.isEmpty || userId.isEmpty) return;

      final firebaseOrder = FirebaseOrderModel.fromApiResponse(order);

      await _ordersRef.child(orderId).set(firebaseOrder.toJson());

      await _usersRef.child(userId).child('orders').child(orderId).set({
        'orderId': orderId,
        'state': order.state ?? 'pending',
        'createdAt': order.createdAt ?? DateTime.now().toIso8601String(),
      });

      debugPrint('Order saved to Firebase successfully!');
    } catch (e) {
      debugPrint('Error saving order to Firebase: $e');
    }
  }

  Future<void> syncUserOrdersWithFirebase(
      String userId, UserOrdersEntitiy orders) async {
    try {
      for (final order in orders.orders) {
        final orderId = order.id;
        if (order.state?.toLowerCase() == 'canceled' ||
            order.state?.toLowerCase() == 'cancelled') {
          continue;
        }
        final snapshot = await _ordersRef.child(orderId ?? '').get();

        if (!snapshot.exists) {

          await sendOrderToFirebase(order);
        }
      }
    } catch (e) {
      throw Exception('Failed to sync orders with Firebase: $e');
    }
  }

  Stream<String> listenToOrderStatus(String orderId) {
    return _ordersRef
        .child(orderId)
        .child('state')
        .onValue
        .map((event) => event.snapshot.value as String? ?? 'pending');
  }

  Stream<Map<String, double>> listenToDriverLocation(String orderId) {
    return _ordersRef.child(orderId).child('location').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) {
        return {'lat': 0.0, 'lng': 0.0};
      }
      return {
        'lat': (data['lat'] as num?)?.toDouble() ?? 0.0,
        'lng': (data['lng'] as num?)?.toDouble() ?? 0.0,
      };
    });
  }

  static Future<void> _sendOrdersToFirebase(List<Map<String, dynamic>> mappedOrders, String userId) async {
    try {
      final dbRef = FirebaseDatabase.instance.ref('orders');
      final userOrdersRef = FirebaseDatabase.instance.ref('users/$userId/orders');

      for (final orderData in mappedOrders) {
        final orderId = orderData['orderId'];
        if (orderId == null || orderId.isEmpty) continue;

        final snapshot = await dbRef.child(orderId).get();

        if (!snapshot.exists) {
          await dbRef.child(orderId).set(orderData);
          
          await userOrdersRef.child(orderId).set(orderData);
          
          debugPrint('Order saved to Firebase: $orderId');
        }
      }

      debugPrint('All orders processed successfully');
    } catch (e) {
      debugPrint('Error sending orders to Firebase: $e');
    }
  }

}
