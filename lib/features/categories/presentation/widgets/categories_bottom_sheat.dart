import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/categories/presentation/manager/categories_cubit.dart';
import 'package:flower_app/features/categories/presentation/manager/categories_states.dart';
import 'package:flower_app/features/categories/presentation/widgets/custom_radio.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesBottomSheet extends StatelessWidget {
  final CategoriesCubit cubit;
  final String? categoryId;

  const CategoriesBottomSheet(
      {super.key, required this.cubit, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filterOptions = [
      {
        'value': SortOption.lowestPrice,
        'title': LocaleKeys.filter_lowestPrice.tr(),
        'query': 'price',
      },
      {
        'value': SortOption.highestPrice,
        'title': LocaleKeys.filter_highestPrice.tr(),
        'query': '-price',
      },
      {
        'value': SortOption.newest,
        'title': LocaleKeys.filter_new.tr(),
        'query': 'createdAt',
      },
      {
        'value': SortOption.oldest,
        'title': LocaleKeys.filter_old.tr(),
        'query': '-createdAt',
      },
      {
        'value': SortOption.discount,
        'title': LocaleKeys.filter_discount.tr(),
        'query': 'discount',
      },
    ];

    return BlocListener<CategoriesCubit, CategoriesStates>(
      bloc: cubit,
      listener: (context, state) {
        if (state.categoryState is BaseSuccessState) {
          // Navigator.pop(context);
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
          color: AppColors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
          child: BlocBuilder<CategoriesCubit, CategoriesStates>(
            bloc: cubit,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 100.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: const Color(0xff434343),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    LocaleKeys.filter_sortBy.tr(),
                    style: getExtraBoldStyle(
                        color: AppColors.primary, fontSize: 20.sp),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemCount: filterOptions.length,
                      itemBuilder: (context, index) {
                        final option = filterOptions[index];
                        return CustomRadio<SortOption>(
                          value: option['value'],
                          groupValue: state.selectedSortOption,
                          title: option['title'] as String,
                          onSelect: (_) => cubit.selectSortOption(option),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    LocaleKeys.filter_price.tr(),
                    style: getMediumStyle(
                        color: AppColors.primary, fontSize: 16.sp),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackShape: const RectangularSliderTrackShape(),
                      valueIndicatorTextStyle: getMediumStyle(
                          color: AppColors.black, fontSize: 16.sp),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 8.r),
                      thumbColor: AppColors.primary,
                    ),
                    child: RangeSlider(
                      values: state.priceRange,
                      max: 250,
                      min: 0,
                      activeColor: AppColors.primary,
                      labels: RangeLabels(
                        state.priceRange.start.round().toString(),
                        state.priceRange.end.round().toString(),
                      ),
                      overlayColor:
                          const WidgetStatePropertyAll(AppColors.primary),
                      onChanged: (value) => cubit.updatePriceRange(value),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${state.priceRange.start.round().toString()}',
                          style: getMediumStyle(
                            color: AppColors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          '\$${state.priceRange.end.round().toString()}',
                          style: getMediumStyle(
                            color: AppColors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: state.categoryState is BaseLoadingState
                        ? null
                        : () {
                            cubit.applyFilter(categoryId);
                            Navigator.pop(context);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.tune_rounded,
                          color: AppColors.white,
                          size: 20.sp,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          LocaleKeys.filter_filterButton.tr(),
                          style: getRegularStyle(
                              color: AppColors.white, fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
