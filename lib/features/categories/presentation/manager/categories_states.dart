// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';

class CategoriesStates extends Equatable {
  final BaseState? categoryState;
  final int? selectedCategoryIndex;
  final List<CategoryOccasionEntity> updatedCategories;
  const CategoriesStates({
    this.categoryState,
    this.selectedCategoryIndex,
    this.updatedCategories = const [],
  });

  CategoriesStates copyWith({
    BaseState? categoryState,
    final int? selectedCategoryIndex,
    List<CategoryOccasionEntity>? updatedCategories,
  }) {
    return CategoriesStates(
      categoryState: categoryState ?? this.categoryState,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      updatedCategories: updatedCategories ?? this.updatedCategories,
    );
  }

  @override
  List<Object> get props =>
      [categoryState ?? '', selectedCategoryIndex ?? 0, updatedCategories];
}
