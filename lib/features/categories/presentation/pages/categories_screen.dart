// features/categories/presentation/pages/categories_screen.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/common_widgets/product_card/product_card_view.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/search/presentation/widgets/search_bar_widget.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../manager/categories_cubit.dart';
import '../manager/categories_states.dart';
import '../widgets/custom_tab_bar.dart';

class CategoriesScreen extends StatefulWidget {
  final int initialTabIndex;
  const CategoriesScreen({super.key, this.initialTabIndex = 0});

  @override
  State<CategoriesScreen> createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen>
    with TickerProviderStateMixin {
  final CategoriesCubit _cubit = getIt<CategoriesCubit>();
  late final List<ScrollController> _scrollControllers;
  late final AnimationController _fabAnimationController;
  late final Animation<Offset> _fabAnimation;

  @override
  void initState() {
    super.initState();

    _scrollControllers = List.generate(
      _cubit.categories.length,
      (_) => ScrollController()..addListener(_onScroll),
    );

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

    // Initialize tab controller with the provided initial index
    _cubit.tabController = TabController(
      length: _cubit.categories.length,
      vsync: this,
      initialIndex: 0,
    );
    // Fetch products for the initial category
    if (_cubit.categories.isNotEmpty) {
      _cubit.getProductByCategoryList(
          _cubit.categories[widget.initialTabIndex].id ?? '');
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
    for (final controller in _scrollControllers) {
      controller.removeListener(_onScroll);
      controller.dispose();
    }
    _fabAnimationController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: Builder(
        builder: (context) {
          return PopScope(
            canPop: false,
            child: Scaffold(
              floatingActionButton: SlideTransition(
                position: _fabAnimation,
                child: FloatingActionButton.extended(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000.r),
                  ),
                  onPressed: () {
                    _cubit.showCategoriesFilterSheet(context);
                  },
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.tune_rounded, color: AppColors.white),
                      SizedBox(width: 12.w),
                      Text("Filter",
                          style: getRegularStyle(color: AppColors.white)),
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    children: [
                      // SearchBar section
                      Row(
                        children: [
                          Expanded(
                            //search bar
                            child: SearchBarWidget(
                              readOnly: true,
                              onTap: () {
                                final selectedCategoryId = _cubit
                                        .categories.isNotEmpty
                                    ? _cubit
                                        .categories[_cubit.tabController.index]
                                        .id
                                    : null;

                                if (selectedCategoryId != null) {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.searchResults,
                                    arguments: {
                                      'categoryId': selectedCategoryId
                                    }
                                  );
                                } else {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.searchResults,
                                    arguments: {}
                                  );
                                }
                              },
                            ),
                          ),
                          /////////////////////////
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () {
                              _cubit.showCategoriesFilterSheet(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.white[70]!, width: 1.w),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: const Icon(Icons.filter_list_outlined,
                                  size: 24),
                            ),
                          ),
                        ],
                      ),
                      // Tab bar section
                      SizedBox(height: 16.h),
                      CustomTabBar(
                        tabController: _cubit.tabController,
                        tabsTitles:
                            _cubit.categories.map((e) => e.name ?? '').toList(),
                        changeTabIndex: (index) {
                          _cubit.tabController.animateTo(index);
                          _cubit.getProductByCategoryList(
                              _cubit.categories[index].id ?? '');
                        },
                      ),
                      SizedBox(height: 16.h),
                      Expanded(
                        child: TabBarView(
                          controller: _cubit.tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: _cubit.categories.asMap().entries.map(
                            (entry) {
                              final index = entry.key;
                              return BlocBuilder<CategoriesCubit,
                                  CategoriesStates>(
                                builder: (context, state) {
                                  if (state.categoryState is BaseLoadingState) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primary,
                                      ),
                                    );
                                  } else if (state.categoryState
                                      is BaseErrorState) {
                                    return Center(
                                      child: Text((state.categoryState
                                              as BaseErrorState)
                                          .errorMessage),
                                    );
                                  }

                                  final products =
                                      (state.categoryState is BaseSuccessState)
                                          ? ((state.categoryState
                                                      as BaseSuccessState)
                                                  .data ??
                                              [])
                                          : [];

                                  if (products.isEmpty) {
                                    return Center(
                                      child: Text(
                                        'No products available',
                                        style: getMediumStyle(
                                            color: AppColors.black,
                                            fontSize: 20.sp),
                                      ),
                                    );
                                  }

                                  return GridView.builder(
                                    controller: _scrollControllers[index],
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.7.r,
                                      crossAxisSpacing: 16.w,
                                      mainAxisSpacing: 16.h,
                                    ),
                                    itemCount: products.length,
                                    itemBuilder: (context, productIndex) {
                                      final p = products[productIndex];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.searchResults,
                                            arguments: {
                                              'categoryId': p.id ?? ''
                                            }
                                          );
                                        },
                                        child: ProductCard(
                                          product: ProductEntity(
                                            id: p.id ?? '',
                                            title: p.title ?? '',
                                            imgCover: p.images?.first ?? '',
                                            price: p.price ?? 0,
                                            priceAfterDiscount:
                                                p.priceAfterDiscount ?? 0,
                                            images: p.images ?? [],
                                            description: p.description ?? '',
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
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
          );
        },
      ),
    );
  }
}
