import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/cart/presentation/widgets/cart_product/widgets/title_and_delete.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/common_widgets/app_network_image/app_network_image.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_colors.dart';
import 'widgets/quantity_and_price_section.dart';

class CartProductWidget extends StatelessWidget {
  final bool isDummy;
  const CartProductWidget({
    super.key,
    this.isDummy = false,
    required this.productEntity,
  });

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    const double rightMargining = 30;
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.productDetailsView,
              arguments: productEntity);
        },
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
                border: Border.all(width: 1.h)),
            child: Row(children: [
              /// Image
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: AppNetworkImage(
                      networkImage: productEntity.imgCover,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  )),

              /// Product Details
              Expanded(
                  flex: 7,
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// title + delete
                            CartProductTitleAndRemoveIcon(
                              title: productEntity.title,
                              id: productEntity.id,
                              isDummy: isDummy,
                            ),

                            /// discription
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  end: rightMargining),
                              child: Text(
                                productEntity.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: getMediumStyle(color: AppColors.grey)
                                    .copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400),
                              ),
                            ),
                            const Spacer(),
                            CartProductPriceAndQuantitySection(productEntity),
                          ])))
            ])));
  }
}
