import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class DeliveryOptionItem extends StatelessWidget {
  final String type;
  final String address;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  const DeliveryOptionItem({
    super.key,
    required this.type,
    required this.address,
    required this.isSelected,
    required this.onTap,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      highlightColor: AppColors.primary[20],
      splashColor: AppColors.primary[10],
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      value: true,
                      groupValue: isSelected,
                      onChanged: (_) => onTap(),
                      activeColor: AppColors.primary,
                      fillColor: WidgetStateProperty.all(AppColors.primary),
                      visualDensity: VisualDensity.compact,
                    ),
                    Text(
                      type,
                      style: getMediumStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12),
                  child: Text(
                    address,
                    style: getRegularStyle(
                      color: AppColors.grey,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: Colors.grey),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }
}
