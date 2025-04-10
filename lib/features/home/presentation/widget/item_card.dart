// features/home/presentation/widget/item_card.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/common_widgets/app_network_image/app_network_image.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_icons.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/occasion/presentation/pages/occasion_page.dart';
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
  final ProductEntity? product;
  final VoidCallback? onTap;
  final CategoryOccasionEntity? occasion;
  final int? occasionIndex;
  final List<CategoryOccasionEntity>? occasionList;

  const ItemCard({
    super.key,
    this.id,
    this.title,
    this.imageUrl,
    this.showPrice = false,
    this.price,
    this.discountPrice,
    this.product,
    this.onTap,
    this.occasion,
    this.occasionIndex,
    this.occasionList,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final cardWidth = size.width * 0.3;
    final imageSize = cardWidth * .9;
    final iconSize = size.width * 0.07;
    final marginRight = size.width * 0.02;

    return GestureDetector(
      onTap: onTap ?? () {
        if (product != null) {
          Navigator.pushNamed(
            context,
            Routes.productDetailsView,
            arguments: product,
          );
        } else if (occasion != null && occasionList != null && occasionIndex != null) {
          print("Navigating to occasion: $occasionIndex - ${occasion?.name}");
          Navigator.pushNamed(
            context,
            Routes.occasion,
            arguments: OccasionPageArguments(
              categories: occasionList,
              selectedCategoryIndex: occasionIndex,
            ),
          );
        }
      },
      child: Container(
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
                  ? AppNetworkImage(
                      networkImage: imageUrl!,
                      borderRadius: BorderRadius.circular(4.r))
                  : Container(
                      color: AppColors.grey,
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
                  fontSize: 11.sp, 
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
                      ? '$discountPrice ${'common.currency'.tr()}'
                      : '$price ${'common.currency'.tr()}',
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
      ),
    );
  }
}
