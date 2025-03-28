// features/home/presentation/widget/item_card.dart

import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_icons.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final String? price;
  final bool isOccasion;

  const ItemCard({
    super.key,
    required this.name,
    this.price,
    this.isOccasion = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      margin: EdgeInsets.only(right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: SvgPicture.asset(AppIcons.flower),
          ),
          SizedBox(height: 8.h),
          Text(
            name,
            style: getMediumStyle(
              color: AppColors.black,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.start,
          ),
          if (price != null) ...[
            SizedBox(height: 4.h),
            Text(
              price!,
              style: getRegularStyle(
                color: AppColors.black,
                fontSize: 12.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
