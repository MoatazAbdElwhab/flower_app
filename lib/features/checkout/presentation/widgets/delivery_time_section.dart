import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryTimeSection extends StatelessWidget {
  const DeliveryTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery time',
                style: getMediumStyle(
                  color: AppColors.black,
                  fontSize: 18.sp,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Schedule',
                  style: getBoldStyle(
                    color: AppColors.primary,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                'Instant, ',
                style: getMediumStyle(
                  color: AppColors.black,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                'Arrive by 03 Sep 2024, 11:00 AM',
                style: getMediumStyle(
                  color: AppColors.success,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
