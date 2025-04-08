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
    var size = MediaQuery.of(context).size;
    
    // Make item cards smaller to prevent overflow
    final cardWidth = size.width * 0.25; 
    final imageSize = cardWidth;
    final iconSize = size.width * 0.07; 
    final loaderSize = size.width * 0.05;
    final marginRight = size.width * 0.02; 
    
    return Container(
      width: cardWidth,
      margin: EdgeInsets.only(right: marginRight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: imageSize,
            height: imageSize,
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
                      fadeInDuration: const Duration(milliseconds: 300),
                      fadeOutDuration: const Duration(milliseconds: 300),
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: loaderSize,
                          height: loaderSize,
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
                            width: iconSize,
                            height: iconSize,
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
                        width: iconSize,
                        height: iconSize,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
          ),
          SizedBox(height: size.height * 0.005), 
          SizedBox(
            width: cardWidth,
            child: Text(
              title ?? 'home.items.unknown'.tr(),
              style: getMediumStyle(
                color: AppColors.black,
                fontSize: 11.sp, // Smaller font
              ),
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (showPrice && price != null) ...[
            SizedBox(height: size.height * 0.002), 
            SizedBox(
              width: cardWidth,
              child: Text(
                discountPrice != null 
                    ? '${discountPrice} ${'common.currency'.tr()}'
                    : '${price} ${'common.currency'.tr()}',
                style: getRegularStyle(
                  color: AppColors.black,
                  fontSize: 10.sp, 
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          SizedBox(height: size.height * 0.002), 
        ],
      ),
    );
  }
}
