// features/home/presentation/widget/item_card.dart

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
      onTap: onTap ??
          () {
            if (product != null) {
              Navigator.pushNamed(
                context,
                Routes.productDetailsView,
                arguments: product,
              );
            } else if (occasion != null &&
                occasionList != null &&
                occasionIndex != null) {
              Navigator.pushNamed(
                context,
                Routes.occasion,
                arguments: OccasionPageArguments(
                  categories: occasionList!,
                  selectedCategoryIndex: occasionIndex!,
                ),
              );
            }
          },
      child: SizedBox(
        width: 120.w,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 8,
                child: imageUrl != null && imageUrl.isNotEmpty
                    ? AppNetworkImage(
                        networkImage: imageUrl,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: AppColors.grey,
                        child: Center(
                          child: SvgPicture.asset(
                            AppIcons.flower,
                            width: 30.w,
                            height: 30.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 4.h),
              Expanded(
                flex: 1,
                child: Text(
                  title ?? 'home.items.unknown'.tr(),
                  style: getMediumStyle(
                    color: AppColors.black,
                    fontSize: 12.sp,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (showPrice)
                Expanded(
                  flex: 1,
                  child: Text(
                    product!.priceAfterDiscount != 0
                        ? '${product!.priceAfterDiscount} ${'common.currency'.tr()}'
                        : '${product!.price} ${'common.currency'.tr()}',
                    style: getRegularStyle(
                      color: AppColors.black,
                      fontSize: 11.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
