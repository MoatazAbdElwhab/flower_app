// features/home/presentation/widget/item_card.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_icons.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemCard extends StatelessWidget {
  final String? id;
  final String? title;
  final String? imageUrl;
  final bool showPrice;
  final String? price;
  final String? discountPrice;

  const ItemCard({
    super.key,
    this.id,
    this.title,
    this.imageUrl,
    this.showPrice = false,
    this.price,
    this.discountPrice,
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
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      memCacheWidth: 240,
                      memCacheHeight: 240,
                      maxWidthDiskCache: 480,
                      maxHeightDiskCache: 480,
                      fadeInDuration: const Duration(milliseconds: 300),
                      fadeOutDuration: const Duration(milliseconds: 300),
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.w,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.grey.withOpacity(0.1),
                        child: Center(
                          child: SvgPicture.asset(
                            AppIcons.flower,
                            width: 40.w,
                            height: 40.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    color: AppColors.grey.withOpacity(0.1),
                    child: Center(
                      child: SvgPicture.asset(
                        AppIcons.flower,
                        width: 40.w,
                        height: 40.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 6.h),
          Text(
            title ?? 'home.items.unknown'.tr(),
            style: getMediumStyle(
              color: AppColors.black,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (showPrice && price != null) ...[
            SizedBox(height: 2.h),
            Text(
              discountPrice != null 
                  ? '${discountPrice} ${'common.currency'.tr()}'
                  : '${price} ${'common.currency'.tr()}',
              style: getRegularStyle(
                color: AppColors.black,
                fontSize: 12.sp,
              ),
            ),
          ],
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
