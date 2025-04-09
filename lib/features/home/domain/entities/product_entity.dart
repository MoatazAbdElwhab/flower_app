// features/home/domain/entities/product_entity.dart

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

  const ProductEntity({
    required this.id,
    required this.title,
    required this.imgCover,
    required this.price,
    required this.priceAfterDiscount,
    required this.images,
    required this.description,
  });

  @override
  List<Object> get props => [
        id,
        title,
        imgCover,
        price,
        priceAfterDiscount,
        images,
        description,
      ];

  static ProductEntity mapProductToEntity(Product model) {
    return ProductEntity(
      id: model.id ?? '',
      title: model.title ?? '',
      imgCover: model.imgCover ?? '',
      price: model.price ?? 0,
      priceAfterDiscount: model.priceAfterDiscount ?? 0,
      images: model.images ?? [],
      description: model.description ?? '',
    );
  }
}
