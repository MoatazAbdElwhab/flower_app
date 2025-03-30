// features/home/presentation/widget/location_bar.dart

import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationBar extends StatelessWidget {
  const LocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 20.sp,
          color: Colors.black87,
        ),
        SizedBox(width: 4.w),
        Text(
          'Deliver to 2XVP+XC - Sheikh Zayed',
          style: getRegularStyle(
            color: AppColors.black,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(width: 2.w),
        Icon(
          Icons.keyboard_arrow_down,
          size: 20.sp,
          color: AppColors.primary,
        ),
        const Spacer(),
      ],
    );
  }
}
