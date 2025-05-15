import 'package:equatable/equatable.dart';

class FirebaseOrderItem extends Equatable {
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String image;

  const FirebaseOrderItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'title': title,
    'price': price,
    'quantity': quantity,
    'image': image,
  };

  factory FirebaseOrderItem.fromJson(Map<String, dynamic> json) {
    return FirebaseOrderItem(
      productId: json['productId'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
      image: json['image'],
    );
  }

  factory FirebaseOrderItem.fromApiResponse(Map<String, dynamic> item) {
    return FirebaseOrderItem(
      productId: item['product']['_id'],
      title: item['product']['title'],
      price: (item['price'] as num).toDouble(),
      quantity: item['quantity'],
      image: item['product']['imgCover'],
    );
  }

  @override
  List<Object?> get props => [productId, title, price, quantity, image];
}