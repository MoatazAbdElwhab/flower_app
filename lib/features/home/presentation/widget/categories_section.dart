// features/home/presentation/widget/categories_section.dart

import 'package:flower_app/features/home/presentation/widget/category_item.dart';
import 'package:flower_app/features/home/presentation/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //section header
        const SectionHeader(title: 'Categories'),
        SizedBox(height: 12.h),

        //categories list view
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              CategoryItem(name: 'Flowers', icon: Icons.local_florist),
              CategoryItem(name: 'Gift', icon: Icons.card_giftcard),
              CategoryItem(name: 'Card', icon: Icons.credit_card),
              CategoryItem(name: 'Jewellery', icon: Icons.diamond),
              CategoryItem(name: 'Flowers', icon: Icons.local_florist),
            ],
          ),
        ),
      ],
    );
  }
}
