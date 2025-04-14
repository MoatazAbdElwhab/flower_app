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
  final ProductEntity? product;
  final CategoryOccasionEntity? occasion;
  final int? occasionIndex;
  final List<CategoryOccasionEntity>? occasionList;
  final VoidCallback? onTap;

  const ItemCard({
    super.key,
    this.product,
    this.occasion,
    this.occasionIndex,
    this.occasionList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String? title = product?.title ?? occasion?.name;
    final String? imageUrl = product?.imgCover ?? occasion?.image;
    final bool showPrice = product != null;

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
        width: 100.w,
        margin: EdgeInsets.only(right: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 90.w,
              height: 90.w,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? AppNetworkImage(
                      networkImage: imageUrl,
                      borderRadius: BorderRadius.circular(4.r))
                  : Container(
                      color: AppColors.grey,
                      child: Center(
                        child: SvgPicture.asset(
                          AppIcons.flower,
                          width: 24.w,
                          height: 24.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              width: 100.w,
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
            if (showPrice) ...[
              SizedBox(height: 2.h),
              SizedBox(
                width: 100.w,
                child: Text(
                  product!.priceAfterDiscount != 0
                      ? '${product!.priceAfterDiscount} ${'common.currency'.tr()}'
                      : '${product!.price} ${'common.currency'.tr()}',
                  style: getRegularStyle(
                    color: AppColors.black,
                    fontSize: 10.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
