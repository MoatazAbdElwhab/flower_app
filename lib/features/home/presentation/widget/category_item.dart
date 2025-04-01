// features/home/presentation/widget/category_item.dart

import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  final CategoryEntity category;

  const CategoryItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65.w,
      margin: EdgeInsets.only(right: 16.w),
      child: Column(
        children: [
          Container(
            width: 70.w,
            height: 70.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary[10],
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: category.image != null
                ? SizedBox(
                    width: 20.w,
                    height: 25.h,
                    child: Image.network(
                      category.image!,
                      width: 20.w,
                      height: 25.h,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.local_florist,
                        color: AppColors.primary,
                        size: 20.sp,
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: SizedBox(
                            width: 15.w,
                            height: 15.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.w,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Icon(
                    Icons.local_florist,
                    color: AppColors.primary,
                    size: 20.sp,
                  ),
          ),
          SizedBox(height: 8.h),
          Text(
            category.name ?? 'Unknown',
            style: getRegularStyle(
              color: AppColors.black,
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
