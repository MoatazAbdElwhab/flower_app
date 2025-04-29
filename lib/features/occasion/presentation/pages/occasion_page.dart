// features/occasion/presentation/pages/occasion_page.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/common_widgets/dummy_widgets/dummy_widgets.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/occasion/presentation/cubit/occasion_cubit.dart';
import 'package:flower_app/core/common_widgets/grid_view_widget/product_grid.dart';
import 'package:flower_app/core/common_widgets/tab_bar_widget/sources_tabs.dart';
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
  late OccasionCubit cubit;
  @override
  void initState() {
    super.initState();
    // Create dummy items for each category
    categoryItems = AppDummyWidgets().categoryItems;

    cubit = getIt<OccasionCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit.selectedCategoryIndex.value =
        widget.arguments.selectedCategoryIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit
        ..getOccasionsProducts(widget
                .arguments.categories?[cubit.selectedCategoryIndex.value].id ??
            '673b34c21159920171827ae0'),
      child: DefaultTabController(
        length: widget.arguments.categories?.length ?? 0,
        initialIndex: cubit.selectedCategoryIndex.value,
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
                      categories: widget.arguments.categories ?? [],
                      onTabChanged: (index) {
                        cubit.switchTab(
                            index: index,
                            categoryOccasionId:
                                widget.arguments.categories?[index].id ?? '');
                      },
                    );
                  },
                ),
                BlocBuilder<OccasionCubit, OccasionState>(
                  builder: (context, state) {
                    if (state.occasionsProductsState is BaseErrorState) {
                      final error =
                          state.occasionsProductsState as BaseErrorState;
                      return Center(child: Text(error.errorMessage));
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
