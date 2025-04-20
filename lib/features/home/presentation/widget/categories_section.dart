// features/home/presentation/widget/categories_section.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:flower_app/features/home/presentation/widget/category_item.dart';
import 'package:flower_app/features/home/presentation/widget/section_header.dart';
import 'package:flower_app/features/nav/presentation/cubit/nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injectable.dart';
import '../../../categories/presentation/manager/categories_cubit.dart';

class CategoriesSection extends StatelessWidget {
  final List<CategoryOccasionEntity> categories;
  //final VoidCallback? onViewAllTap;

  const CategoriesSection({
    super.key,
    required this.categories,
    // this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //////////////////////////////////////////////////Categories section header
        SectionHeader(
          title: 'home.sections.categories'.tr(),
          onViewAllTap: () {
            context.read<NavCubit>().changeTab(
                  1,
              selectedCategoryIndex: 0,
                );
          },
        ),

        SizedBox(height: 5.h),

        //////////////////////////////////////////////////categories list view
        SizedBox(
          height: 75.h,
          child: categories.isEmpty
              ? Center(child: Text('home.empty_states.categories'.tr()))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryItem(
                      category: categories[index],
                      onTap: () {
                        context
                            .read<NavCubit>()
                            .changeTab(1, selectedCategoryIndex: index);
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
