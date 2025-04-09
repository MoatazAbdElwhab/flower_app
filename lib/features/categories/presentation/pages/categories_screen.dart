import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/common_widgets/product_card/product_card_view.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../manager/categories_cubit.dart';
import '../manager/categories_states.dart';
import '../widgets/custom_tab_bar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late CategoriesCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<CategoriesCubit>();
    _cubit.initTabController(this, _cubit.categories.length);
    _cubit.initScrollController(this);
    if (_cubit.categories.isNotEmpty) {
      _cubit.getProductByCategoryList(_cubit.categories[0].id ?? '');
    }
    _cubit.tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_cubit.tabController.indexIsChanging) {
      return;
    }
    _cubit.changeTab(_cubit.tabController.index);
    _cubit.getProductByCategoryList(
        _cubit.categories[_cubit.tabController.index].id ?? '');
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _cubit.close();
    _cubit.tabController.removeListener(_onTabChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: _cubit,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: SlideTransition(
            position: _cubit.fabAnimation,
            child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1000.r),
              ),
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              backgroundColor: AppColors.primary,
              onPressed: () {
                _cubit.showCategoriesFilterSheet(context);
              },
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.tune_rounded,
                    color: AppColors.white,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    "Filter",
                    style: getRegularStyle(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
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
                                color: AppColors.white[70]!, width: 1.w),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                                color: AppColors.white[70]!, width: 1.w),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                                color: AppColors.white[70]!, width: 1.w),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                                color: AppColors.white[70]!, width: 1.w),
                          ),
                          hintText: 'Search',
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.white[70]!, width: 1.w),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: const Icon(Icons.filter_list_outlined, size: 24),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                BlocBuilder<CategoriesCubit, CategoriesStates>(
                  bloc: _cubit,
                  builder: (context, state) {
                    return Column(
                      children: [
                        CustomTabBar(
                          tabController: _cubit.tabController,
                          tabsTitles:
                          _cubit.categories.map((e) => e.name).toList(),
                          selectedIndex: _cubit.tabIndex.value,
                          changeTabIndex: (index) {
                            _cubit.changeTab(index);
                          },
                        ),
                        SizedBox(height: 32.h),
                        Expanded(
                          child: state.categoryState is BaseLoadingState
                              ? const Center(
                            child: CircularProgressIndicator(),
                          )
                              : state.categoryState is BaseErrorState
                              ? Center(
                            child: Text(
                              (state.categoryState as BaseErrorState)
                                  .errorMessage,
                            ),
                          )
                              : TabBarView(
                            controller: _cubit.tabController,
                            children: _cubit.categories.map((category) {
                              List<Products> products =
                              state.categoryState
                              is BaseSuccessState
                                  ? (state.categoryState
                              as BaseSuccessState)
                                  .data!
                                  : [];
                              return products.isEmpty
                                  ? Center(
                                  child: Text(
                                    'No products available',
                                    style: getMediumStyle(
                                        color: AppColors.black,
                                        fontSize: 20.sp),
                                  ))
                                  : GridView.builder(
                                controller:
                                _cubit.scrollController,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7.r,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 16.h,
                                ),
                                itemCount: products.isNotEmpty
                                    ? products.length
                                    : 1,
                                itemBuilder: (context, index) {
                                  final product = ProductEntity(
                                    id: products[index].id ?? '',
                                    title: products[index]
                                        .title ??
                                        '',
                                    imgCover: products[index]
                                        .images
                                        ?.first ??
                                        '',
                                    price: products[index]
                                        .price ??
                                        0,
                                    priceAfterDiscount:
                                    products[index]
                                        .priceAfterDiscount ??
                                        0,
                                    images: products[index]
                                        .images ??
                                        [],
                                    description:
                                    products[index]
                                        .description ??
                                        '',
                                  );
                                  return ProductCard(
                                    product: product,
                                    onAddToCartTap: () {},
                                    isInCart: false,
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}