import 'package:flutter/material.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String title;
  final void Function(T?) onSelect;
  final Color activeColor;
  final TextStyle? titleStyle;

  const CustomRadio({
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onSelect,
    this.activeColor = AppColors.primary,
    this.titleStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return Semantics(
      checked: isSelected,
      label: title,
      child: InkWell(
        splashColor: activeColor.withAlpha(32),
        onTap: () {
          onSelect(value);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withAlpha(46),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: titleStyle ??
                    getMediumStyle(
                      fontSize: 16.sp,
                      color: isSelected ? activeColor : AppColors.black,
                    ),
                child: Text(title),
              ),
              Radio<T>(
                value: value,
                groupValue: groupValue,
                onChanged: (T? newValue) {
                  onSelect(newValue);
                },
                activeColor: activeColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum SortOption {
  lowestPrice,
  highestPrice,
  newest,
  oldest,
  discount,
}
