import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_styles.dart';
import '../../../../../checkout/domain/entities/address.dart';

class AddressWidget extends StatelessWidget {
  final Address address;
  final GestureTapCallback onTap;
  const AddressWidget({super.key, required this.address, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      highlightColor: AppColors.primary[20],
      splashColor: AppColors.primary[10],
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.25),
              blurRadius: 4,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on_outlined),
                Expanded(
                  child: Text(
                    address.city,
                    overflow: TextOverflow.ellipsis,
                    style: getMediumStyle(
                      color: AppColors.black,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: () {

                    },
                    child: SvgPicture.asset(
                        'assets/icons/delete_icon.svg'),
                  ),
                ),
                InkWell(
                    onTap: () {

                    },
                    child: Icon(Icons.edit_outlined))
              ],
            ),
            Text(
              address.street,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: getRegularStyle(
                color: AppColors.grey,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// IconButton(
// icon: const Icon(Icons.edit_outlined, color: Colors.grey),
// onPressed: () {
//
// },
// ),