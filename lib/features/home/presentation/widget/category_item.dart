// features/home/presentation/widget/category_item.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/common_widgets/app_network_image/app_network_image.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  final CategoryOccasionEntity category;
  final int index;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.category,
    this.index = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54.w,
        margin: EdgeInsets.only(right: 8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 54.w,
              height: 54.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary[10],
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: category.image != null
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: AppNetworkImage(
                        networkImage: category.image!,
                        fit: BoxFit.contain,
                        placeHolder: SizedBox(
                          width: 14.w,
                          height: 14.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.w,
                            color: AppColors.primary,
                          ),
                        ),
                        errorBuilder: Icon(
                          Icons.local_florist,
                          color: AppColors.primary,
                          size: 20.w,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.local_florist,
                      color: AppColors.primary,
                      size: 20.w,
                    ),
            ),
            SizedBox(height: 4.h),
            Text(
              category.name ?? 'home.items.unknown'.tr(),
              style: getRegularStyle(
                color: AppColors.black,
                fontSize: 11.sp,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
