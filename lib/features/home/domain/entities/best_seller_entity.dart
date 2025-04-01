// features/home/domain/entities/best_seller_entity.dart

import 'package:equatable/equatable.dart';
import 'package:flower_app/features/home/data/model/response/home/best_seller.dart';

class BestSellerEntity extends Equatable {
  final String? id;
  final String? title;
  final String? imgCover;
  final int? price;
  final int? priceAfterDiscount;

  const BestSellerEntity({
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


  static BestSellerEntity mapBestSellerToEntity(BestSeller model) {
    return BestSellerEntity(
      id: model.id,
      title: model.title,
      imgCover: model.imgCover,
      price: model.price,
      priceAfterDiscount: model.priceAfterDiscount,
    );
  }
}
