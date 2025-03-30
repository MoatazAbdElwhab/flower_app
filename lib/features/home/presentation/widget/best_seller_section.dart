// features/home/presentation/widget/best_seller_section.dart

import 'package:flower_app/features/home/presentation/widget/item_card.dart';
import 'package:flower_app/features/home/presentation/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //section header
        const SectionHeader(title: 'Best seller'),
        SizedBox(height: 12.h),

        //best seller list view
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              ItemCard(name: 'Sunny', price: '600 EGP'),
              ItemCard(name: 'Red roses', price: '600 EGP'),
              ItemCard(name: 'Spring vase', price: '600 EGP'),
            ],
          ),
        ),
      ],
    );
  }
}
