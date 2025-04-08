import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_styles.dart';

class CardPriceRow extends StatelessWidget {
  final num? priceAfterDiscount;
  final num? originalPrice;

  const CardPriceRow({
    super.key,
    this.priceAfterDiscount,
    required this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: priceAfterDiscount == null
          ? Text(
          'EGP ${originalPrice == null ? 'error' : originalPrice!.toStringAsFixed(2)}',
          overflow: TextOverflow.ellipsis,
          style: getMediumStyle(color: AppColors.black, fontSize: 14.sp))
          : FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('EGP $priceAfterDiscount  ',
                overflow: TextOverflow.ellipsis,
                style: getMediumStyle(
                    color: AppColors.black, fontSize: 14.sp)),
            Text(
              '${originalPrice!.toString()}  ',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.black,
                decorationThickness: 2.w,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${((originalPrice! - priceAfterDiscount!) / originalPrice! * 100).ceil()}%',
              style: getRegularStyle(color: AppColors.success),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}