import 'package:equatable/equatable.dart';
import 'package:flower_app/core/sharedModels/fire_base_order_model.dart';

import '../../../home/domain/entities/category_occasion_entity.dart';

class NavState extends Equatable {
  final int tabIndex;
  final int? selectedCategoryIndex;
  final List<CategoryOccasionEntity> categories;
  final UserDataModel? userDataModel;

  const NavState({
    required this.tabIndex,
    this.selectedCategoryIndex,
    this.categories = const [],
     this.userDataModel,
  });

  NavState copyWith({
    int? tabIndex,
    int? selectedCategoryIndex,
    List<CategoryOccasionEntity>? categories,
    UserDataModel? userDataModel,
  }) {
    return NavState(
      tabIndex: tabIndex ?? this.tabIndex,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      categories: categories ?? this.categories,
      userDataModel: userDataModel ?? this.userDataModel,
    );
  }

  @override
  List<Object?> get props => [tabIndex, selectedCategoryIndex, categories, userDataModel];

}