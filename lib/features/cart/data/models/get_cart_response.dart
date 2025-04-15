import 'CartDm.dart';

class GetCartResponse {
  GetCartResponse({
    String? message,
    num? numOfCartItems,
    CartDm? cart,
  }) {
    _message = message;
    _numOfCartItems = numOfCartItems;
    _cart = cart;
  }

  GetCartResponse.fromJson(dynamic json) {
    _message = json['message'];
    _numOfCartItems = json['numOfCartItems'];
    _cart = json['cart'] != null ? CartDm.fromJson(json['cart']) : null;
  }
  String? _message;
  num? _numOfCartItems;
  CartDm? _cart;

  String? get message => _message;
  num? get numOfCartItems => _numOfCartItems;
  CartDm? get cart => _cart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['numOfCartItems'] = _numOfCartItems;
    if (_cart != null) {
      map['cart'] = _cart?.toJson();
    }
    return map;
  }
}
