import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/domain/entities/category_occasion_entity.dart';
import 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavState(tabIndex: 0));

  void changeTab(int index, {int? selectedCategoryIndex}) {
    emit(state.copyWith(
      tabIndex: index,
      selectedCategoryIndex: selectedCategoryIndex,
    ));
  }

  void getCategories(List<CategoryOccasionEntity> categories) {
    emit(state.copyWith(categories: categories));
  }
}