import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flower_app/core/sharedModels/fire_base_order_model.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/user_orders_entitiy.dart';

class FirebaseIsolateHelper {
  static bool _isSyncing = false;

  static Future<void> syncOrdersInIsolate(
      UserOrdersEntitiy ordersData, UserDataModel userData) async {
    if (_isSyncing || ordersData.orders.isEmpty) return;

    _isSyncing = true;

    try {
      await _syncUserData(userData);

      final filteredOrders = ordersData.orders.where((order) {
        final orderState = order.state?.toLowerCase() ?? '';
        return orderState != 'canceled' && orderState != 'cancelled';
      }).toList();

      if (filteredOrders.isEmpty) {
        debugPrint('No non-cancelled orders to sync');
        return;
      }

      final existingOrderIds =
          await _getExistingOrderIds(userData.userId ?? '');
      final newOrders = filteredOrders
          .where((order) => !existingOrderIds.contains(order.id))
          .toList();

      if (newOrders.isEmpty) {
        debugPrint('No new orders to sync');
        return;
      }

      debugPrint('Found ${newOrders.length} new orders to sync');

      final isHeavyOperation = newOrders.length > 5;

      if (isHeavyOperation) {
        debugPrint('Using compute for heavy mapping operation');

        final mappedOrders =
            await compute<Map<String, dynamic>, List<Map<String, dynamic>>>(
                _mapOrdersToFirebaseFormat,
                {'orders': newOrders, 'userData': userData});

        await _sendOrdersToFirebase(mappedOrders, userData.userId ?? '');
      } else {
        debugPrint('Using microtask for light operation');

        Future.microtask(() async {
          try {
            final dbRef = FirebaseDatabase.instance.ref('orders');
            final userOrdersRef = FirebaseDatabase.instance
                .ref('users/${userData.userId}/orders');

            for (final order in newOrders) {
              final orderId = order.id;
              if (orderId == null || orderId.isEmpty) continue;

              try {
                final snapshot = await dbRef.child(orderId).get();

                if (!snapshot.exists) {
                  final firebaseOrder =
                      FirebaseOrderModel.fromApiResponseWithUserData(
                          order, userData);

                  await dbRef.child(orderId).set(firebaseOrder.toJson());
                  await userOrdersRef
                      .child(orderId)
                      .set(firebaseOrder.toJson());

                  debugPrint('Order saved to Firebase: $orderId');
                }
              } catch (e) {
                debugPrint('Error processing order $orderId: $e');
              }
            }
            debugPrint('All orders synced successfully');
          } catch (e) {
            debugPrint('Background sync error: $e');
          }
        });
      }

      debugPrint('Firebase sync initiated');
    } catch (e) {
      debugPrint('Error starting sync: $e');
    } finally {
      _isSyncing = false;
    }
  }

  static Future<Set<String>> _getExistingOrderIds(String userId) async {
    final Set<String> existingOrderIds = {};

    try {
      final userOrdersRef =
          FirebaseDatabase.instance.ref('users/$userId/orders');
      final snapshot = await userOrdersRef.get();

      if (snapshot.exists && snapshot.value != null) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        existingOrderIds.addAll(data.keys.map((key) => key.toString()));
      }

      debugPrint(
          'Found ${existingOrderIds.length} existing orders in Firebase');
    } catch (e) {
      debugPrint('Error getting existing order IDs: $e');
    }

    return existingOrderIds;
  }

  static Future<void> _syncUserData(UserDataModel userData) async {
    if (userData.userId == null || userData.userId!.isEmpty) {
      debugPrint('Cannot sync user data: missing user ID');
      return;
    }

    try {
      final userRef = FirebaseDatabase.instance.ref('users/${userData.userId}');
      final snapshot = await userRef.get();

      if (!snapshot.exists) {
        final userMap = _mapUserDataToFirebase(userData);
        await userRef.set(userMap);
        debugPrint('User data synced to Firebase: ${userData.userId}');
      }
    } catch (e) {
      debugPrint('Error syncing user data: $e');
    }
  }

  static Map<String, dynamic> _mapUserDataToFirebase(UserDataModel userData) {
    return {
      'userId': userData.userId,
      'name': userData.name,
      'phone': userData.phone,
      'city': userData.city,
      'street': userData.street,
      'location': userData.locationData.toJson(),
      'paymentMethod': userData.paymentMethod,
      // 'lastSync': DateTime.now().toIso8601String(),
    };
  }

  static List<Map<String, dynamic>> _mapOrdersToFirebaseFormat(
      Map<String, dynamic> data) {
    final List<dynamic> orders = data['orders'];
    final UserDataModel userData = data['userData'];

    return orders.map((order) {
      try {
        final storeAddress = {
          'title': 'Flowery store',
          'address': '20th st, Sheikh Zayed, Giza',
          'location': {'lat': "29.9773", 'lng': "31.1325"}
        };

//         Map<String, dynamic> toJson() {
//   return {
//     '_id': id,
//     'name': firstName,
//     'email': email,
//     'gender': gender,
//     'phone': phone,
//     'photo': photo,
//     'address': address,
//   };
// }

// factory Customer.fromJson(Map<String, dynamic> json) {
//   return Customer(
//     id: json['_id'] as String?,
//     firstName: json['firstName'] as String?,
//     email: json['email'] as String?,
//     gender: json['gender'] as String?,
//     phone: json['phone'] as String?,
//     photo: json['photo'] as String?,
//     address: json['address'] as String?,
//   );
// }

        final Map<String, dynamic> userDataMap = {
          '_id': userData.userId,
          'name': userData.name,
          'phone': userData.phone,
          // 'city': userData.city,
           'address': userData.city + userData.street,
          // 'street': userData.street,
          // 'paymentMethod': order.paymentType ?? 'cash',
          'location': {
            'lat': userData.locationData.lat,
            'lng': userData.locationData.lng,
          },
        };

        List<Map<String, dynamic>> items = [];
        try {
          if (order.orderItems != null && order.orderItems.isNotEmpty) {
            items = order.orderItems
                .map<Map<String, dynamic>>((item) => {
                      'productId': item.product?.id ?? item.product?._id ?? '',
                      'title': item.product?.title ?? 'Product',
                      'price': item.price ?? 0.0,
                      'quantity': item.quantity ?? 1,
                      'image': item.product?.imgCover ?? '',
                    })
                .toList();
          }
        } catch (e) {
          debugPrint('Error extracting order items: $e');
        }

        return {
          'orderId': order.id ?? order._id ?? '',
          'orderNumber': order.orderNumber ?? '',
          'userId': userData.userId,
          'items': items,
          'totalPrice': order.totalPrice ?? 0.0,
          'paymentType': order.paymentType ?? 'cash',
          'isPaid': order.isPaid ?? false,
          'isDelivered': order.isDelivered ?? false,
          'state': order.state ?? 'pending',
          'createdAt': order.createdAt ?? DateTime.now().toIso8601String(),
          // 'location': {
          //   'lat': userData.locationData.lat,
          //   'lng': userData.locationData.lng
          // },
          'estimatedArrival':
              DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
          'driver': {
            'driverId': 'Null',
            'name': "Null",
            'phone': "Null",
            // 'status': "Null",
          },
          'pickupAddress': storeAddress,
          'user': userDataMap,
        };
      } catch (e) {
        debugPrint('Error mapping order: $e');
        return {'error': 'Failed to map order', 'orderId': order.id ?? ''};
      }
    }).toList();
  }

  static Future<void> _sendOrdersToFirebase(
      List<Map<String, dynamic>> mappedOrders, String userId) async {
    try {
      final dbRef = FirebaseDatabase.instance.ref('orders');
      final userOrdersRef =
          FirebaseDatabase.instance.ref('users/$userId/orders');

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
