import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';
import 'package:flower_app/features/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../home/domain/entities/category_occasion_entity.dart';
import '../widgets/categories_bottom_sheat.dart';
import 'categories_states.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesStates> {
  final List<CategoryOccasionEntity> categories;

  CategoriesCubit(this._getCategoriesUseCase, this.categories)
      : super(const CategoriesStates());

  final GetCategoriesUseCase _getCategoriesUseCase;
  late TabController tabController;

  void showCategoriesFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const CategoriesBottomSheet(),
    );
  }

  Future<void> getProductByCategoryList(String categoriesId) async {
    emit(state.copyWith(categoryState: BaseLoadingState()));
    var categoriesList = await _getCategoriesUseCase.call(categoriesId);
    emit(
      state.copyWith(
        categoryState: categoriesList.fold(
          (error) => BaseErrorState(error.message),
          (products) => BaseSuccessState<List<Products>>(data: products),
        ),
      ),
    );
  }

  Future<void> selectCategoryFromHomeByID(String categoryId) async {
    final index =
        categories.indexWhere((category) => category.id == categoryId);

    if (index >= 0) {
      final selectedCategory = categories.removeAt(index);
      categories.insert(0, selectedCategory);

      tabController.index = 0;
      emit(state.copyWith(
          selectedCategoryIndex: 0, updatedCategories: categories));
      await getProductByCategoryList(selectedCategory.id ?? '');
    } else {
      await getProductByCategoryList(categoryId);

      emit(state.copyWith(
        categoryState: BaseErrorState('Invalid category ID'),
      ));
    }
  }
}
