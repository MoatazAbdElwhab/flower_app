// features/home/presentation/widget/item_card.dart

import 'package:cached_network_image/cached_network_image.dart';
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
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => SvgPicture.asset(
                        AppIcons.flower,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : SvgPicture.asset(AppIcons.flower),
          ),
          SizedBox(height: 8.h),
          Text(
            title ?? 'Unknown',
            style: getMediumStyle(
              color: AppColors.black,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (showPrice && price != null) ...[
            SizedBox(height: 4.h),
            Text(
              discountPrice != null ? '$discountPrice EGP' : '$price EGP',
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
