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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? AppColors.primary : AppColors.white[70]!,
            width: 3,
          ),
        ),
      ),
      child: Text(
        title,
        style: getRegularStyle(
          color: isSelected ? AppColors.primary : AppColors.white[70]!,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
