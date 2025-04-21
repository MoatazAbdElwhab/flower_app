import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/occasion/presentation/widgets/product_grid.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../nav/presentation/cubit/nav_cubit.dart';
import '../../../nav/presentation/cubit/nav_state.dart';
import '../manager/categories_cubit.dart';
import '../manager/categories_states.dart';
import '../widgets/custom_tab_bar.dart';

class CategoriesScreen extends StatefulWidget {
  final int selectedCategoryIndex;
  final List<CategoryOccasionEntity> categories;

  const CategoriesScreen({
    super.key,
    this.selectedCategoryIndex = 0,
    this.categories = const [],
  });

  @override
  State<CategoriesScreen> createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final CategoriesCubit _cubit = getIt<CategoriesCubit>();
  late List<ScrollController> _scrollControllers;
  late AnimationController _fabAnimationController;
  late Animation<Offset> _fabAnimation;
  TabController? _tabController;

  final List<ProductEntity> dummyProducts = List.generate(
    15,
        (index) => ProductEntity(
      id: index.toString(),
      title: 'Flower Bouquet ${index + 1}',
      imgCover: 'https://via.placeholder.com/150',
      price: 100,
      priceAfterDiscount: 80,
      images: const [],
      description: '',
    ),
  );

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _cubit.initializeSelectedIndex(widget.selectedCategoryIndex);

    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fabAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 2),
    ).animate(CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeInOut,
    ));

    _setupTabAndScrollControllers();
  }

  void _setupTabAndScrollControllers() {
    _tabController?.removeListener(_syncTabWithCubit);
    _tabController?.dispose();

    _tabController = TabController(
      length: widget.categories.length,
      vsync: this,
      initialIndex: widget.selectedCategoryIndex,
    )..addListener(_syncTabWithCubit);

    _scrollControllers = List.generate(
      widget.categories.length,
          (_) => ScrollController()..addListener(_onScroll),
    );

    if (widget.categories.isNotEmpty &&
        _cubit.state.selectedCategoryIndex! < widget.categories.length) {
      _cubit.getProductByCategoryList(
        widget.categories[_cubit.state.selectedCategoryIndex ?? 0].id ?? '',
      );
    }
  }

  @override
  void didUpdateWidget(CategoriesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.categories != oldWidget.categories) {
      _setupTabAndScrollControllers();
    }
  }

  void _syncTabWithCubit() {
    if (_tabController!.indexIsChanging) {
      final newIndex = _tabController!.index;
      if (newIndex != _cubit.state.selectedCategoryIndex) {
        _cubit.updateSelectedCategoryIndex(newIndex);
        getIt<NavCubit>().changeTab(1, selectedCategoryIndex: newIndex);
        _cubit.getProductByCategoryList(
          widget.categories[newIndex].id ?? '',
        );
      }
    }
  }

  void _onScroll() {
    for (final controller in _scrollControllers) {
      if (!controller.hasClients) continue;
      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        _fabAnimationController.forward();
      } else if (controller.position.userScrollDirection ==
          ScrollDirection.forward) {
        _fabAnimationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_syncTabWithCubit);
    _tabController?.dispose();
    for (final controller in _scrollControllers) {
      controller.removeListener(_onScroll);
      controller.dispose();
    }
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => _cubit,
      child: BlocListener<NavCubit, NavState>(
        listener: (context, state) {
          if (state.selectedCategoryIndex != null &&
              state.selectedCategoryIndex! < widget.categories.length &&
              state.selectedCategoryIndex != _tabController?.index) {
            _tabController?.animateTo(state.selectedCategoryIndex!,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 300));
          }
        },
        child: PopScope(
          canPop: false,
          child: Scaffold(
            floatingActionButton: widget.categories.isNotEmpty
                ? SlideTransition(
                    position: _fabAnimation,
                    child: FloatingActionButton.extended(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000.r),
                      ),
                      onPressed: () {
                        // print((_tabController?.index));
                        String? id =
                            widget.categories[_tabController?.index ?? 0].id;
                        print(id);
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => CategoriesBottomSheet(
                            cubit: _cubit,
                            categoryId: id,
                          ),
                        );
                      },
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.tune_rounded,
                              color: AppColors.white),
                          SizedBox(width: 12.w),
                          Text(
                            "Filter",
                            style: getRegularStyle(color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: widget.categories.isEmpty
                    ? Center(
                        child: Text(
                          "No categories found \nplease try again later",
                          textAlign: TextAlign.center,
                          style: getBoldStyle(
                              color: AppColors.black, fontSize: 16),
                        ),
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                          color: AppColors.white[70]!,
                                          width: 1.w),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                          color: AppColors.white[70]!,
                                          width: 1.w),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                          color: AppColors.white[70]!,
                                          width: 1.w),
                                    ),
                                    hintText:
                                        LocaleKeys.home_sections_search.tr(),
                                    hintStyle:
                                        getMediumStyle(color: AppColors.grey),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 12.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.white[70]!,
                                        width: 1.w),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: const Icon(Icons.filter_list_outlined,
                                      size: 24),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          CustomTabBar(
                            tabController: _tabController!,
                            tabsTitles: widget.categories
                                .map((e) => e.name ?? '')
                                .toList(),
                            changeTabIndex: (index) {
                              _tabController!.animateTo(index);
                            },
                          ),
                          SizedBox(height: 16.h),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: widget.categories.asMap().entries.map(
                                (entry) {
                                  final index = entry.key;
                                  return KeyedSubtree(
                                    key: ValueKey(widget.categories[index].id),
                                    child: BlocBuilder<CategoriesCubit,
                                        CategoriesStates>(
                                      buildWhen: (previous, current) =>
                                          previous.categoryState !=
                                              current.categoryState &&
                                          current.selectedCategoryIndex ==
                                              index,
                                      builder: (context, state) {
                                        final bool isLoading =
                                            (state.categoryState
                                                    is BaseLoadingState ||
                                                state.categoryState
                                                    is BaseInitialState);
                                        final List<ProductEntity> products =
                                            isLoading
                                                ? dummyProducts
                                                : (state.categoryState
                                                        is BaseSuccessState
                                                    ? (state.categoryState
                                                                as BaseSuccessState)
                                                            .data ??
                                                        []
                                                    : []);

                                  if (products.isEmpty && !isLoading) {
                                    return Center(
                                      child: Text(
                                        'No products available',
                                        style: getMediumStyle(
                                            color: AppColors.black, fontSize: 20.sp),
                                      ),
                                    );
                                  }
                                  if (state.categoryState is BaseErrorState) {
                                    return Center(
                                      child: Text(
                                        (state.categoryState as BaseErrorState).errorMessage,
                                      ),
                                    );
                                  }

                                  return Skeletonizer(
                                    enabled: isLoading,
                                    child: ProductGrid(
                                      items: products,
                                      controller: _scrollControllers[index],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
