import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/profile/data/models/get_user_oreders_response/user_orders_response.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserOrdersWidget extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final Orders order;
  final String orderStatus;
  final int index;
  final void Function()? onPressed;

  const UserOrdersWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.order,
    required this.orderStatus,
    required this.index,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grey,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            margin: EdgeInsets.all(8.w),
            width: 127.w,
            height: 110.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              image: imageUrl != null && imageUrl!.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: AssetImage('assets/images/placeholder.png'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Product Title
                  Text(
                    title.isNotEmpty ? title : '',
                    style: getRegularStyle(
                      fontSize: 14.sp,
                      color: AppColors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  // Price
                  Text(
                    '${LocaleKeys.myOrders_Curnncy.tr()} ${order.orderItems != null && order.orderItems!.isNotEmpty ? (order.orderItems?[0].price?.toStringAsFixed(2) ?? '0.00') : '0.00'}',
                    style: getBoldStyle(
                      fontSize: 14.sp,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  // Order Number
                  Text(
                    '${LocaleKeys.myOrders_orderNum.tr()} ${order.orderNumber ?? 'N/A'}',
                    style: getRegularStyle(
                      fontSize: 12.sp,
                      color: AppColors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: Size(double.infinity, 36.h),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      child: Text(
                        orderStatus,
                        style: getRegularStyle(
                          color: AppColors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
