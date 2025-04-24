import 'package:flower_app/features/home/data/model/response/home/product.dart';

class OrderItem {
  final Product? product;
  final int? price;
  final int? quantity;
  final String? id;

  const OrderItem({this.product, this.price, this.quantity, this.id});

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        product: json['product'] == null
            ? null
            : Product.fromJson(json['product'] as Map<String, dynamic>),
        price: json['price'] as int?,
        quantity: json['quantity'] as int?,
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'product': product?.toJson(),
        'price': price,
        'quantity': quantity,
        '_id': id,
      };
}
