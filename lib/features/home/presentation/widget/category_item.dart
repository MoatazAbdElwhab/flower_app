// features/home/presentation/widget/category_item.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/common_widgets/app_network_image/app_network_image.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  final CategoryOccasionEntity category;
  final void Function()? onTap;

  const CategoryItem({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      margin: EdgeInsets.only(right: 4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 55.w,
            height: 55.w,
            decoration: BoxDecoration(
              color: AppColors.primary[10],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(12.r),
                child: Center(
                  child: category.image != null
                      ? SizedBox(
                          width: 25.w,
                          height: 25.h,
                          child: AppNetworkImage(
                            networkImage: category.image!,
                            fit: BoxFit.contain,
                            placeHolder: SizedBox(
                              width: 15.w,
                              height: 15.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.w,
                                color: AppColors.primary,
                              ),
                            ),
                            errorBuilder: Icon(
                              Icons.local_florist,
                              color: AppColors.primary,
                              size: 25.w,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.local_florist,
                          color: AppColors.primary,
                          size: 25.w,
                        ),
                ),
              ),
            ),
          ),
          SizedBox(height: 3.h),
          SizedBox(
            height: 12.h,
            child: Text(
              category.name ?? 'home.items.unknown'.tr(),
              style: getRegularStyle(
                color: AppColors.black,
                fontSize: 10.sp,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
