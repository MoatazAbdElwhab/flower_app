// features/home/presentation/widget/categories_section.dart

import 'package:flower_app/features/home/domain/entities/category_entity.dart';
import 'package:flower_app/features/home/presentation/widget/category_item.dart';
import 'package:flower_app/features/home/presentation/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesSection extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoriesSection({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //////////////////////////////////////////////////Categories section header
        const SectionHeader(title: 'Categories'),
        SizedBox(height: 12.h),

        //////////////////////////////////////////////////categories list view
        Expanded(
          child: categories.isEmpty
              ? const Center(child: Text('No categories available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryItem(
                      category: categories[index],
                    );
                  },
                ),
        ),
      ],
    );
  }
}
