// features/home/domain/entities/category_entity.dart

import 'package:equatable/equatable.dart';
import 'package:flower_app/features/home/data/model/response/home/category.dart';

class CategoryEntity extends Equatable {
  final String? id;
  final String? name;
  final String? image;

  const CategoryEntity({
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

  static CategoryEntity mapCategoryToEntity(Category model) {
    return CategoryEntity(
      id: model.id,
      name: model.name,
      image: model.image,
    );
  }
}
