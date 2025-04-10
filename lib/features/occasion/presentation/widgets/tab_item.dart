import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.title,
    this.isSelected = false,
  });
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: getRegularStyle(
              color: isSelected ? AppColors.primary : AppColors.white[70]!,
              fontSize: 16.sp,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.white[70]!,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(100),
              ),
            ),
          )
        ],
      ),
    );
  }
}
