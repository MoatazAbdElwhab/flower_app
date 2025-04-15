import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/core/theme/app_colors.dart';

class CustomLangRadio extends StatelessWidget {
  final String title;
  final Locale localeValue;
  final Locale selectedLocale;
  final void Function(Locale) onSelected;

  const CustomLangRadio({
    super.key,
    required this.title,
    required this.localeValue,
    required this.selectedLocale,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(localeValue),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          color: AppColors.white[20],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: getMediumStyle(
                fontSize: 16.sp,
                color: AppColors.black,
              ),
            ),
            Radio<Locale>(
              value: localeValue,
              groupValue: selectedLocale,
              onChanged: (value) => onSelected(value!),
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
