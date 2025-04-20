import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/features/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/nav/presentation/cubit/nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../widgets/categories_bottom_sheat.dart';
import 'categories_states.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit(this._getCategoriesUseCase) : super(const CategoriesStates());

  final GetCategoriesUseCase _getCategoriesUseCase;

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
              (products) => BaseSuccessState<List<ProductEntity>>(data: products),
        ),
      ),
    );
  }

  void initializeSelectedIndex(int index) {
    emit(state.copyWith(selectedCategoryIndex: index));
  }

  void updateSelectedCategoryIndex(int index) {
    emit(state.copyWith(selectedCategoryIndex: index));
    getIt<NavCubit>().changeTab(1, selectedCategoryIndex: index);
  }
}