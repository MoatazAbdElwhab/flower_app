import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';
import 'package:flower_app/features/categories/domain/entities/categories_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../manager/categories_cubit.dart';
import '../manager/categories_states.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/product_cart_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late CategoriesCubit _cubit;
  late final List<CategoriesEntity> categories;
  final List<String> tabsTitles = ["Flowers", "Gifts", "Chocolates", "Cards"];

  @override
  void initState() {
    super.initState();
    _cubit = getIt<CategoriesCubit>()
      ..getCategrioesProuductList('673c46fd1159920171827c85');
    _cubit.initTabController(this, tabsTitles.length);
    _cubit.initScrollController(this);
  }
  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _cubit.close();
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
                  builder: (context, state) {
                    final cubit = context.read<CategoriesCubit>();
                    return CustomTabBar(
                      tabController: cubit.tabController,
                      tabsTitles: tabsTitles,
                      selectedIndex: cubit.tabIndex.value,
                      changeTabIndex: cubit.changeTab,
                    );
                  },
                ),
                SizedBox(height: 32.h),
                Expanded(
                  child: BlocBuilder<CategoriesCubit, CategoriesStates>(
                    builder: (context, state) {
                      final cubit = context.read<CategoriesCubit>();
                      if (state.categoryState is BaseLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.categoryState is BaseErrorState) {
                        return Center(
                          child: Text(
                            (state.categoryState as BaseErrorState)
                                .errorMessage,
                          ),
                        );
                      }
                      return TabBarView(
                        controller: cubit.tabController,
                        children: tabsTitles.map(
                              (category) => GridView.builder(
                                
                            controller: cubit.scrollController,
                            gridDelegate:
                             SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7.r,
                              crossAxisSpacing: 16.w,
                              mainAxisSpacing: 16.h,
                            ),
                                itemCount: state.categoryState
                                        is BaseSuccessState
                                    ? (state.categoryState as BaseSuccessState)
                                        .data!
                                        .length
                                    : 0,
                            itemBuilder: (context, index) {
                                  List<Products> products =
                                      (state.categoryState as BaseSuccessState)
                                          .data!;
                              return ProductCardWidget(
                                    imageUrl: products[index].images![0],
                                    title: products[index].title ?? '',
                                    price: products[index].price?.toDouble() ??
                                        0.0,
                                    priceAfterDiscount: products[index]
                                            .priceAfterDiscount
                                            ?.toDouble() ??
                                        0.0,
                                    heroTag: products[index].id ?? '',
                                onPressed: () {},
                                buttonIcon: Icons.add,
                                buttonTitle: "Add to Cart",
                                onCardPressed: () {},
                              );
                            },
                          ),
                        ).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
 
}