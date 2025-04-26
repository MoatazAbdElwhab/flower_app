import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class UserOdersLoadingWidget extends StatelessWidget {
  const UserOdersLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
    padding: EdgeInsets.all(16.w),
    itemCount: 5, 
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              Container(
                margin: EdgeInsets.all(8.w),
                width: 127.w,
                height: 110.h,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150.w,
                        height: 16.h,
                        color: Colors.grey[200],
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        width: 80.w,
                        height: 16.h,
                        color: Colors.grey[200],
                      ),
                      SizedBox(height: 3.h),

                      Container(
                        width: 120.w,
                        height: 14.h,
                        color: Colors.grey[200],
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: double.infinity,
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
  }
}