// features/home/presentation/widget/home_header.dart

import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_icons.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        children: [
          // Logo section
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(6.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary[10],
                ),
                child: SvgPicture.asset(
                  AppIcons.flower,
                  width: 15.w,
                  height: 15.h,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                "Flowery",
                style: getRegularStyle(
                  color: AppColors.primary,
                  fontSize: 23.sp,
                ),
              ),
            ],
          ),

          SizedBox(width: 12.w),

          //textform Search field
          Expanded(
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColors.white[70]!,
                  width: 1,
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.white[70]!,
                    size: 20.sp,
                  ),
                  hintText: 'Search',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
