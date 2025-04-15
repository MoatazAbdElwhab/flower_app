import 'package:equatable/equatable.dart';
import 'package:flower_app/features/home/data/model/response/home/product.dart';

class ProductEntity extends Equatable {
  final String id;
  final String title;
  final String imgCover;
  final int price;
  final int priceAfterDiscount;
  final List<String> images;
  final String description;
  int? _cartQuantity;
  num? _totalPrice;

  ProductEntity({
    required this.id,
    required this.title,
    required this.imgCover,
    required this.price,
    required this.priceAfterDiscount,
    required this.images,
    required this.description,
    int? cartQuantity,
    num? totalPrice,
  }) {
    _cartQuantity = cartQuantity;
    if (_cartQuantity != null) {
      _totalPrice = _cartQuantity! * price;
    } else {
      _totalPrice = totalPrice;
    }
  }

  int? get cartQuantity => _cartQuantity;
  num? get totalPrice => _totalPrice;

  set cartQuantity(int? value) {
    _cartQuantity = value;
    if (_cartQuantity != null) {
      _totalPrice = _cartQuantity! * price;
    } else {
      _totalPrice = null;
    }
  }

  @override
  List<Object?> get props => [
    id,
    title,
    imgCover,
    price,
    priceAfterDiscount,
    images,
    description,
    _totalPrice,
    _cartQuantity
  ];

  Product formEntityToModel(ProductEntity entity) {
    return Product(
        id: entity.id,
        title: entity.title,
        imgCover: entity.imgCover,
        price: entity.price,
        priceAfterDiscount: entity.priceAfterDiscount,
        availableQuantity: entity.cartQuantity,
        images: entity.images,
        description: entity.description);
  }
}
final prod =ProductEntity(id: 'id', title: 'title', imgCover: 'imgCover',
    price: 22, priceAfterDiscount: 22, images: [], description: '',
cartQuantity: 2);