import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';
import 'package:flower_app/features/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

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
  

  // Initialize TabController
  void initTabController(TickerProvider vsync, int length) {
    tabController = TabController(length: length, vsync: vsync);
    tabController.addListener(
      () {
        if (!tabController.indexIsChanging) {
          tabIndex.value = tabController.index;
        }
      },
    );
  }

  // Initialize ScrollController and AnimationController
  void initScrollController(TickerProvider vsync) {
    scrollController = ScrollController();

    // Initialize AnimationController
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );

    // Define FAB animation
    fabAnimation = Tween<Offset>(
      begin: const Offset(0, 0), // Visible position
      end: const Offset(0, 1), // Hidden position (slides down)
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Add scroll listener
    scrollController.addListener(() {
      if (scrollController.hasClients) {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          _animationController.forward();
        } else if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          _animationController.reverse();
        }
      }
    });
  }
  // Change tab programmatically
  void changeTab(int index) {
    tabIndex.value = index;
    tabController.animateTo(index,
        curve: Curves.bounceIn, duration: const Duration(milliseconds: 500));
  }

  void showCategoriesFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const CategoriesBottomSheet(),
    );
  }

  void getCategrioesProuductList(String categrioesId) async{
    emit(state.copyWith(categoryState: BaseLoadingState()));
    var categoriesList = await _getCategoriesUseCase.call(categrioesId);
    emit(state.copyWith(
      categoryState: categoriesList.fold(
        (error) => BaseErrorState(error.message),
        (products) => BaseSuccessState<List<Products>>(data: products),
      ),
    ));
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
