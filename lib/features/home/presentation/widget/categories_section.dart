// features/home/presentation/widget/categories_section.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/features/categories/presentation/pages/categories_screen.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:flower_app/features/home/presentation/widget/category_item.dart';
import 'package:flower_app/features/home/presentation/widget/section_header.dart';
import 'package:flower_app/features/nav/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesSection extends StatelessWidget {
  final List<CategoryOccasionEntity> categories;

  const CategoriesSection({
    super.key,
    required this.categories,
  });

  void navigateToCategory(BuildContext context, int categoryIndex) {
    if (categoryIndex < 0 || categoryIndex >= categories.length) return;
    
    final categoryName = categories[categoryIndex].name;
    if (categoryName == null || categoryName.isEmpty) return;
    
    CategoriesScreen.navigateToCategory(context, categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionHeader(
          title: 'home.sections.categories'.tr(),
          onViewAllTap: () {
            final navbarState = NavbarPage.of(context);
            if (navbarState != null) {
              navbarState.changeTab(1);
            } else {
              Navigator.pushNamed(
                context,
                Routes.categories,
              );
            }
          },
        ),

        SizedBox(height: 5.h),

        SizedBox(
          height: 100.h,
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
                      index: index,
                      onTap: () => navigateToCategory(context, index),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
