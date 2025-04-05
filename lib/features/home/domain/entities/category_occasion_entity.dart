// features/home/domain/entities/category_occasion_entity.dart

import 'package:equatable/equatable.dart';
import 'package:flower_app/features/home/data/model/response/home/category.dart';
import 'package:flower_app/features/home/data/model/response/home/occasion.dart';

class CategoryOccasionEntity extends Equatable {
  final String? id;
  final String? name;
  final String? image;

  const CategoryOccasionEntity({
    this.id,
    this.name,
    this.image,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
      ];

  static CategoryOccasionEntity mapCategoryToEntity(Category model) {
    return CategoryOccasionEntity(
      id: model.id,
      name: model.name,
      image: model.image,
    );
  }

  static CategoryOccasionEntity mapOccasionToEntity(Occasion model) {
    return CategoryOccasionEntity(
      id: model.id,
      name: model.name,
      image: model.image,
    );
  }
}
