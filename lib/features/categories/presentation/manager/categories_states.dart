// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/categories/presentation/widgets/custom_radio.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:flutter/material.dart';

class CategoriesStates extends Equatable {
  final BaseState? categoryState;
  final int? selectedCategoryIndex;
  final List<CategoryOccasionEntity> updatedCategories;
  // filter
  final SortOption selectedSortOption;
  final String queryOption;
  final RangeValues priceRange;

  const CategoriesStates({
    this.categoryState,
    this.selectedCategoryIndex,
    this.updatedCategories = const [],
    this.selectedSortOption = SortOption.discount,
    this.queryOption = 'discount',
    this.priceRange = const RangeValues(0, 250),
  });

  CategoriesStates copyWith({
    BaseState? categoryState,
    final int? selectedCategoryIndex,
    List<CategoryOccasionEntity>? updatedCategories,
    SortOption? selectedSortOption,
    String? queryOption,
    RangeValues? priceRange,
  }) {
    return CategoriesStates(
      categoryState: categoryState ?? this.categoryState,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      updatedCategories: updatedCategories ?? this.updatedCategories,
      selectedSortOption: selectedSortOption ?? this.selectedSortOption,
      queryOption: queryOption ?? this.queryOption,
      priceRange: priceRange ?? this.priceRange,
    );
  }

  @override
  List<Object> get props => [
        categoryState ?? '',
        selectedCategoryIndex ?? 0,
        updatedCategories,
        selectedSortOption,
        queryOption,
        priceRange
      ];
}
