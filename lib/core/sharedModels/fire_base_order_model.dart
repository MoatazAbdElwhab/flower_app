// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flower_app/core/sharedModels/pick_up_address.dart';
import 'package:flutter/material.dart';

import '../../features/profile/data/models/profile_data_response/user_data_model.dart';
import 'driver_info.dart';
import 'fire_base_order_item.dart';
import 'location_data.dart';

class FirebaseOrderModel extends Equatable {
  final String orderId;
  final String orderNumber;
  final String userId;
  final List<FirebaseOrderItem> items;
  final double totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final String createdAt;
  final LocationData driverLocation;
  final String estimatedArrival;
  final DriverInfo? driver;
  final PickUPAddress? pickupAddress;
  final UserDataModel? userDataModel;
  // final Address? userAddress;
  // final String? userName;

  const FirebaseOrderModel({
    required this.orderId,
    required this.orderNumber,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.createdAt,
    required this.driverLocation,
    required this.estimatedArrival,
    this.driver,
    this.pickupAddress,
    this.userDataModel,
    // this.userAddress,
    // this.userName,
  });

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'orderNumber': orderNumber,
        'userId': userId,
        'items': items.map((item) => item.toJson()).toList(),
        'totalPrice': totalPrice,
        'paymentType': paymentType,
        'isPaid': isPaid,
        'isDelivered': isDelivered,
        'state': state,
        'createdAt': createdAt,
        'location': driverLocation.toJson(),
        'estimatedArrival': estimatedArrival,
        'driver': driver?.toJson() ??
            {
              'driverId': 'Null',
              'name': 'Null',
              'phone': 'Null',
              // 'status': 'Null',
            },
        'user': userDataModel?.toJson(), 
        'pickupAddress': pickupAddress?.toJson(),
      };

  factory FirebaseOrderModel.fromJson(Map<String, dynamic> json) {
    return FirebaseOrderModel(
      orderId: json['orderId'],
      orderNumber: json['orderNumber'],
      userId: json['userId'],
      items: (json['items'] as List)
          .map((item) => FirebaseOrderItem.fromJson(item))
          .toList(),
      totalPrice: json['totalPrice'].toDouble(),
      paymentType: json['paymentType'],
      isPaid: json['isPaid'],
      isDelivered: json['isDelivered'],
      state: json['state'],
      createdAt: json['createdAt'],
      driverLocation: LocationData.fromJson(json['location']),
      estimatedArrival: json['estimatedArrival'],
      driver:
          json['driver'] != null ? DriverInfo.fromJson(json['driver']) : null,
      pickupAddress: json['pickupAddress'] != null
          ? PickUPAddress.fromJson(json['pickupAddress'])
          : null,
      // userAddress: json['userAddress'] != null ? Address.fromJson(json['userAddress']) : null,
      // userName: json['userName'],
      userDataModel: json['userDataModel'] != null
          ? UserDataModel.fromJson(json['userDataModel'])
          : null,
    );
  }

  // Updated to match the correct Orders structure
  factory FirebaseOrderModel.fromApiResponse(dynamic order) {
    const storeAddress = PickUPAddress(
      title: 'Flowery store',
      address: '20th st, Sheikh Zayed, Giza',
      location: LocationData(lat: "29.9773", lng: "31.1325"),
    );

    UserDataModel? userDataModel;
    try {
      final userField = order.user;
      if (userField != null) {
        if (userField is! String) {
          userDataModel = UserDataModel(
            name: userField.firstName != null 
                ? '${userField.firstName} ${userField.lastName ?? ''}'
                : (userField.name ?? 'Customer'),
            userId: userField._id ?? '',
            phone: userField.phone ?? '',
            paymentMethod: order.paymentType,
            city: userField.city ?? '',
            street: userField.street ?? '',
            locationData: LocationData(
              lat: userField.lat?.toString() ?? "0",
              lng: userField.long?.toString() ?? "0",
            ),
          );
        } else {
          userDataModel = UserDataModel(
            name: 'Customer',
            userId: userField,
            phone: '',
            city: '',
            street: '',
            locationData: const LocationData(lat: "0", lng: "0"),
            paymentMethod: order.paymentType,
          );
        }
      }
    } catch (e) {
      debugPrint('Error extracting user data: $e');
    }

    try {
      if (order.shippingAddress != null) {
        if (userDataModel != null) {
          userDataModel = userDataModel.copyWith(
            city: order.shippingAddress.city ?? '',
            street: order.shippingAddress.street ?? '',
            phone: order.shippingAddress.phone ?? '',
              lat: order.shippingAddress.lat?.toString() ?? "0",
              long: order.shippingAddress.lng?.toString() ?? "0",
          );
        }
      }
    } catch (e) {
      debugPrint('Error extracting shipping address: $e');
    }

    return FirebaseOrderModel(
      orderId: order.id ?? order._id ?? '',
      orderNumber: order.orderNumber ?? '',
      userId: userDataModel?.userId ?? order.user?._id ?? order.user ?? '',
      items: _extractOrderItemsFromOrder(order), 
      totalPrice: order.totalPrice != null ? (order.totalPrice as num).toDouble() : 0.0,
      paymentType: order.paymentType ?? 'cash',
      isPaid: order.isPaid ?? false,
      isDelivered: order.isDelivered ?? false,
      state: order.state ?? 'pending',
      createdAt: order.createdAt ?? DateTime.now().toIso8601String(),
      driverLocation: const LocationData(lat: "0", lng: "0"),
      estimatedArrival: DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
      driver: null,
      pickupAddress: storeAddress,
      userDataModel: userDataModel,
    );
  }

  factory FirebaseOrderModel.fromApiResponseWithUserData(dynamic order, UserDataModel userData) {
    const storeAddress = PickUPAddress(
      title: 'Flowery store',
      address: '20th st, Sheikh Zayed, Giza',
      location: LocationData(lat: "29.9773", lng: "31.1325"),
    );

    return FirebaseOrderModel(
      orderId: order.id ?? order._id ?? '',
      orderNumber: order.orderNumber ?? '',
      userId: userData.userId,
      items: _extractOrderItemsFromOrder(order),
      totalPrice: order.totalPrice != null ? (order.totalPrice as num).toDouble() : 0.0,
      paymentType: order.paymentType ?? 'cash',
      isPaid: order.isPaid ?? false,
      isDelivered: order.isDelivered ?? false,
      state: order.state ?? 'pending',
      createdAt: order.createdAt ?? DateTime.now().toIso8601String(),
      driverLocation: LocationData(lat: userData.locationData.lat, lng: userData.locationData.lng),
      estimatedArrival: DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
      driver: null,
      pickupAddress: storeAddress,
      userDataModel: userData,
    );
  }

  // Helper method to safely extract order items
  static List<FirebaseOrderItem> _extractOrderItemsFromOrder(dynamic order) {
    try {
      if (order.orderItems != null) {
        return _convertToFirebaseOrderItems(order.orderItems);
      } else if (order.products != null) {
        return _convertToFirebaseOrderItems(order.products);
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('Error extracting order items: $e');
      return [];
    }
  }

  static List<FirebaseOrderItem> _convertToFirebaseOrderItems(dynamic items) {
    try {
      return (items as List)
          .map((item) => FirebaseOrderItem(
                productId: item.product?.id ?? '',
                title: item.product?.title ?? '',
                price:
                    item.price != null ? (item.price as num).toDouble() : 0.0,
                quantity: item.quantity ?? 1,
                image: item.product?.imgCover ?? '',
              ))
          .toList();
    } catch (e) {
      debugPrint('Error converting order items: $e');
      return [];
    }
  }

  @override
  List<Object?> get props => [
        orderId,
        orderNumber,
        userId,
        items,
        totalPrice,
        paymentType,
        isPaid,
        isDelivered,
        state,
        createdAt,
        driverLocation,
        estimatedArrival,
        pickupAddress,
        userDataModel,
        // userAddress,
        // userName,
      ];
}



class UserDataModel extends Equatable {
  final String name;
  final String userId;
  final String city;
  final String street;
  final LocationData locationData;
  final String phone;
  final String? paymentMethod;

  const UserDataModel({
    required this.name,
    required this.userId,
    required this.city,
    required this.street,
    required this.locationData,
    required this.phone,
    this.paymentMethod,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'userId': userId,
    'city': city,
    'street': street,
    'location': locationData.toJson(),
    'phone': phone,
    'paymentMethod': paymentMethod,
  };

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      name: json['name'] ?? '',
      userId: json['userId'] ?? '',
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      locationData: LocationData.fromJson(json['location']),
      phone: json['phone'] ?? '',
      paymentMethod: json['paymentMethod'],
    );
  }

  // Convert to Address object for compatibility with other parts of the app
  PickUPAddress toAddress() {
    return PickUPAddress(
      title: name,
      address: '$street, $city',
      location: LocationData(lat: locationData.lat, lng: locationData.lng),
    );
  }

  // Create a copy with updated fields
  UserDataModel copyWith({
    String? name,
    String? userId,
    String? city,
    String? street,
    String? lat,
    String? long,
    String? phone,
    String? paymentMethod,
  }) {
    return UserDataModel(
      name: name ?? this.name,
      userId: userId ?? this.userId,
      city: city ?? this.city,
      street: street ?? this.street,
      locationData: LocationData(
        lat: lat ?? locationData.lat,
        lng: long ?? locationData.lng,
      ),
      phone: phone ?? this.phone,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  List<Object?> get props => [
    name,
    userId,
    city,
    street,
    phone,
    paymentMethod,
  ];
}









