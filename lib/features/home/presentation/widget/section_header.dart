// features/home/presentation/widget/section_header.dart

import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///its for name of the section and the view all button
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: getMediumStyle(
            color: AppColors.black,
            fontSize: 18.sp,
          ),
        ),
        Text(
          'View All',
          style: getTextUnderLine(
            color: AppColors.primary,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
