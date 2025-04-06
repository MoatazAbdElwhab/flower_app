// features/home/domain/entities/product_entity.dart

import 'package:equatable/equatable.dart';
import 'package:flower_app/features/home/data/model/response/home/product.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String? title;
  final String? imgCover;
  final int? price;
  final int? priceAfterDiscount;

  const ProductEntity({
    this.id,
    this.title,
    this.imgCover,
    this.price,
    this.priceAfterDiscount,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        imgCover,
        price,
        priceAfterDiscount,
      ];


  static ProductEntity mapProductToEntity(Product model) {
    return ProductEntity(
      id: model.id,
      title: model.title,
      imgCover: model.imgCover,
      price: model.price,
      priceAfterDiscount: model.priceAfterDiscount,
    );
  }
}
