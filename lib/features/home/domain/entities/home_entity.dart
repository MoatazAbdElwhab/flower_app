// features/home/domain/entities/home_entity.dart

import 'package:equatable/equatable.dart';
import 'package:flower_app/features/home/data/model/response/home/home.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';

class HomeEntity extends Equatable {
  final List<ProductEntity>? products;
  final List<CategoryOccasionEntity>? categories;
  final List<ProductEntity>? bestSeller;
  final List<CategoryOccasionEntity>? occasions;

  const HomeEntity({
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  @override
  List<Object?> get props => [
        products,
        categories,
        bestSeller,
        occasions,
      ];

  static HomeEntity fromModel(Home model) {
    return HomeEntity(
      products: model.products?.map((e) => e.toEntity()).toList(),
      categories: model.categories
          ?.map((e) => CategoryOccasionEntity.mapCategoryToEntity(e))
          .toList(),
      bestSeller: model.bestSeller?.map((e) => e.toEntity()).toList(),
      occasions: model.occasions
          ?.map((e) => CategoryOccasionEntity.mapOccasionToEntity(e))
          .toList(),
    );
  }
}
