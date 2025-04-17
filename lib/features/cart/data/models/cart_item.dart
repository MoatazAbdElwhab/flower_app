import '../../../home/data/model/response/home/product.dart';

class CartItem {
  CartItem({
    Product? product,
    num? price,
    int? productQuantity,
    String? id,
  }) {
    _price = price;
    _productQuantity = productQuantity;
    _product = product?..cartQuantity = productQuantity;
    _id = id;
  }

  CartItem.fromJson(dynamic json) {
    _product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    _product?.cartQuantity = json['quantity'];
    _price = json['price'];
    _productQuantity = json['quantity'];
    _id = json['_id'];
  }
  Product? _product;
  num? _price;
  int? _productQuantity;
  String? _id;
  CartItem copyWith({
    Product? product,
    num? price,
    int? quantity,
    String? id,
  }) =>
      CartItem(
        product: product ?? _product,
        price: price ?? _price,
        productQuantity: quantity ?? _productQuantity,
        id: id ?? _id,
      );
  Product? get product => _product;
  num? get price => _price;
  int? get quantity => _productQuantity;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    map['price'] = _price;
    map['quantity'] = _productQuantity;
    map['_id'] = _id;
    return map;
  }
}
