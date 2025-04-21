import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/category_occasion_entity.dart';

class NavState extends Equatable {
  final int tabIndex;
  final int? selectedCategoryIndex;
  final List<CategoryOccasionEntity> categories;

  const NavState({
    required this.tabIndex,
    this.selectedCategoryIndex,
    this.categories = const [],
  });

  NavState copyWith({
    int? tabIndex,
    int? selectedCategoryIndex,
    List<CategoryOccasionEntity>? categories,
  }) {
    return NavState(
      tabIndex: tabIndex ?? this.tabIndex,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      categories: categories ?? this.categories,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [tabIndex, selectedCategoryIndex, categories];

}