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
    var size = MediaQuery.of(context).size;

    final containerSize = size.width * 0.16;
    final imageSize = size.width * 0.06;
    final loaderSize = size.width * 0.04;
    final marginRight = size.width * 0.02;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: containerSize,
        margin: EdgeInsets.only(right: marginRight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: containerSize,
              height: containerSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary[10],
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: category.image != null
                  ? SizedBox(
                      width: imageSize,
                      height: imageSize,
                      child: AppNetworkImage(
                        networkImage: category.image!,
                        fit: BoxFit.contain,
                        placeHolder: SizedBox(
                          width: loaderSize,
                          height: loaderSize,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.w,
                            color: AppColors.primary,
                          ),
                        ),
                        errorBuilder: Icon(
                          Icons.local_florist,
                          color: AppColors.primary,
                          size: imageSize,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.local_florist,
                      color: AppColors.primary,
                      size: imageSize,
                    ),
            ),
            SizedBox(height: size.height * 0.005),
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
