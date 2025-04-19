// features/search/presentation/widgets/search_bar_widget.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onTextChanged;
  final VoidCallback? onClear;
  final bool autoFocus;
  final bool readOnly;
  final VoidCallback? onTap;

  const SearchBarWidget({
    super.key,
    this.controller,
    this.onTextChanged,
    this.onClear,
    this.autoFocus = false,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        autofocus: autoFocus,
        onTap: onTap,
        onChanged: onTextChanged,
        decoration: InputDecoration(
          hintText: LocaleKeys.home_sections_search.tr(),
          hintStyle: getRegularStyle(
            color: AppColors.grey,
            fontSize: 14.sp,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.grey,
          ),
          suffixIcon: controller != null && controller!.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: AppColors.grey,
                  ),
                  onPressed: onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 8.w,
          ),
        ),
      ),
    );
  }
}
