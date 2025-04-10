// features/categories/presentation/manager/categories_cubit.dart
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';
import 'package:flower_app/features/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../home/domain/entities/category_occasion_entity.dart';
import '../widgets/categories_bottom_sheat.dart';
import 'categories_states.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit(this._getCategoriesUseCase) : super(const CategoriesStates());

  late TabController tabController;
  final GetCategoriesUseCase _getCategoriesUseCase;
  ValueNotifier<int> tabIndex = ValueNotifier<int>(0);

  late ScrollController scrollController;
  late AnimationController _animationController;
  late Animation<Offset> fabAnimation;

  List<CategoryOccasionEntity> categories = getIt<List<CategoryOccasionEntity>>();

  void initTabController(TickerProvider vsync, int length) {
    tabController = TabController(length: length, vsync: vsync);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) tabIndex.value = tabController.index;
    });
  }

  void initScrollController(TickerProvider vsync) {
    scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );

    fabAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 1),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    scrollController.addListener(() {
      if (scrollController.hasClients) {
        if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      }
    });
  }

  void changeTab(int index) {
    if (index < 0 || index >= categories.length) return;

    emit(state.copyWith(categoryState: BaseLoadingState()));
    tabIndex.value = index;
    tabController.animateTo(index, curve: Curves.bounceIn, duration: const Duration(milliseconds: 250));

    Future.delayed(const Duration(milliseconds: 50), () {
      if (categories.isNotEmpty && index < categories.length) {
        getProductByCategoryList(categories[index].id ?? '');
      }
    });
  }

  void showCategoriesFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const CategoriesBottomSheet(),
    );
  }

  void getProductByCategoryList(String categoriesId) async {
    var categoriesList = await _getCategoriesUseCase.call(categoriesId);
    emit(state.copyWith(
      categoryState: categoriesList.fold(
        (error) => BaseErrorState(error.message),
        (products) => BaseSuccessState<List<Products>>(data: products),
      ),
    ));
  }

  static bool navigateToCategory(BuildContext context, String categoryName) {
    try {
      final cubit = getIt<CategoriesCubit>();

      int targetIndex = -1;
      for (int i = 0; i < cubit.categories.length; i++) {
        if (cubit.categories[i].name == categoryName) {
          targetIndex = i;
          break;
        }
      }

      if (targetIndex >= 0) {
        cubit.changeTab(targetIndex);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error navigating to category by name: $e');
      return false;
    }
  }

  @override
  Future<void> close() {
    tabController.dispose();
    scrollController.dispose();
    _animationController.dispose();
    tabIndex.dispose();
    return super.close();
  }
}
