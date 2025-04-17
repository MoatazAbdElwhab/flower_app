import 'cart_item.dart';

class CartDm {
  CartDm({
    String? id,
    String? user,
    List<CartItem>? cartItems,
    num? discount,
    num? totalPrice,
    num? totalPriceAfterDiscount,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) {
    _id = id;
    _user = user;
    _cartItems = cartItems;
    _discount = discount;
    _totalPrice = totalPrice;
    _totalPriceAfterDiscount = totalPriceAfterDiscount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  CartDm.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'];
    if (json['cartItems'] != null) {
      _cartItems = [];
      json['cartItems'].forEach((v) {
        _cartItems?.add(CartItem.fromJson(v));
      });
    }
    _discount = json['discount'];
    _totalPrice = json['totalPrice'];
    _totalPriceAfterDiscount = json['totalPriceAfterDiscount'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _user;
  List<CartItem>? _cartItems;
  num? _discount;
  num? _totalPrice;
  num? _totalPriceAfterDiscount;
  String? _createdAt;
  String? _updatedAt;
  num? _v;

  String? get id => _id;
  String? get user => _user;
  List<CartItem>? get cartItems => _cartItems;
  num? get discount => _discount;
  num? get totalPrice => _totalPrice;
  num? get totalPriceAfterDiscount => _totalPriceAfterDiscount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user'] = _user;
    if (_cartItems != null) {
      map['cartItems'] = _cartItems?.map((v) => v.toJson()).toList();
    }
    map['discount'] = _discount;
    map['totalPrice'] = _totalPrice;
    map['totalPriceAfterDiscount'] = _totalPriceAfterDiscount;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }
  // CartDm copyWith({
  //   String? id,
  //   String? user,
  //   List<CartItems>? cartItems,
  //   num? discount,
  //   num? totalPrice,
  //   num? totalPriceAfterDiscount,
  //   String? createdAt,
  //   String? updatedAt,
  //   num? v,
  // }) =>
  //     CartDm(
  //       id: id ?? _id,
  //       user: user ?? _user,
  //       cartItems: cartItems ?? _cartItems,
  //       discount: discount ?? _discount,
  //       totalPrice: totalPrice ?? _totalPrice,
  //       totalPriceAfterDiscount:
  //       totalPriceAfterDiscount ?? _totalPriceAfterDiscount,
  //       createdAt: createdAt ?? _createdAt,
  //       updatedAt: updatedAt ?? _updatedAt,
  //       v: v ?? _v,
  //     );
}
