// features/home/presentation/widget/occasion_section.dart

import 'package:flower_app/features/home/presentation/widget/item_card.dart';
import 'package:flower_app/features/home/presentation/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OccasionSection extends StatelessWidget {
  const OccasionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //section header
        const SectionHeader(title: 'Occasion'),
        SizedBox(height: 12.h),

        //occasion list view
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              ItemCard(name: 'Wedding', isOccasion: false),
              ItemCard(name: 'Birthday', isOccasion: false),
              ItemCard(name: 'Graduation', isOccasion: false),
            ],
          ),
        ),
      ],
    );
  }
}
