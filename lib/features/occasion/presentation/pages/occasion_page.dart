// features/occasion/presentation/pages/occasion_page.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/occasion/presentation/cubit/occasion_cubit.dart';
import 'package:flower_app/features/occasion/presentation/widgets/product_grid.dart';
import 'package:flower_app/features/occasion/presentation/widgets/sources_tabs.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OccasionPage extends StatefulWidget {
  final OccasionPageArguments arguments;
  const OccasionPage({
    super.key,
    required this.arguments,
  });

  @override
  State<OccasionPage> createState() => _OccasionPageState();
}

class _OccasionPageState extends State<OccasionPage> {
  late List<ProductEntity> categoryItems;
  final cubit = getIt<OccasionCubit>();

  @override
  void initState() {
    super.initState();

    categoryItems = List.generate(
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit.selectedCategoryIndex.value =
        widget.arguments.selectedCategoryIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.arguments.categories;
    final initialIndex = widget.arguments.selectedCategoryIndex ?? 0;

    String? categoryId;
    if (categories != null &&
        categories.isNotEmpty &&
        initialIndex < categories.length) {
      categoryId = categories[initialIndex].id;
    }

    return BlocProvider(
      create: (context) => cubit..getOccasionsProducts(categoryId),
      child: DefaultTabController(
        length: categories?.length ?? 0,
        initialIndex: initialIndex,
        child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.occasionPage_title.tr(),
                  style: getMediumStyle(
                    color: AppColors.black,
                    fontSize: 20.sp,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  LocaleKeys.occasionPage_description.tr(),
                  style: getMediumStyle(color: AppColors.grey, fontSize: 13.sp),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: cubit.selectedCategoryIndex,
                  builder: (context, value, child) {
                    return SourcesTabs(
                      categories: categories ?? [],
                      onTabChanged: (index) {
                        final id =
                            categories != null && index < categories.length
                                ? categories[index].id
                                : null;

                        cubit.switchTab(
                          index: index,
                          categoryOccasionId: id,
                        );
                      },
                    );
                  },
                ),
                BlocBuilder<OccasionCubit, OccasionState>(
                  builder: (context, state) {
                    if (state.occasionsProductsState is BaseErrorState) {
                      final error =
                          state.occasionsProductsState as BaseErrorState;
                      return Expanded(
                        child: Center(
                          child: Text(
                            error.errorMessage,
                            style: getMediumStyle(
                              color: AppColors.error,
                              fontSize: 16.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    // Get products if success state
                    final List<ProductEntity> products;
                    if (state.occasionsProductsState is BaseSuccessState) {
                      products = (state.occasionsProductsState as BaseSuccessState)
                          .data as List<ProductEntity>;

                      // Show "No occasions" message if product list is empty
                      if (products.isEmpty) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              'No occasions available',
                              style: getMediumStyle(
                                color: AppColors.black,
                                fontSize: 18.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    }

                    return Expanded(
                      child: Skeletonizer(
                        enabled:
                            state.occasionsProductsState is BaseLoadingState,
                        child: ProductGrid(
                          items:
                              state.occasionsProductsState is BaseLoadingState
                                  ? categoryItems
                                  : (state.occasionsProductsState
                                          as BaseSuccessState)
                                      .data as List<ProductEntity>,
                        ),
                      ),
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

class OccasionPageArguments {
  final List<CategoryOccasionEntity>? categories;
  final int? selectedCategoryIndex;
  OccasionPageArguments({
    required this.categories,
    this.selectedCategoryIndex,
  });
}
