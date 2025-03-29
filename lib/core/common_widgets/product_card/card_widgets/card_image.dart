import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardImage extends StatelessWidget {
  final String? image;

  const CardImage({
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return image != null
        ? Image.network(image!,
        fit: BoxFit.cover,
        height: 120.h,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) =>
        // DialogUtils.imageErrorBuilder(
        //     context, error, stackTrace, widget.image, 30.h, 30.w),
        const Icon(Icons.error_outline)
    )
        : SizedBox(
      height: 120.h,
      width: double.infinity,
      child: const Icon(
        Icons.warning_amber_outlined,
        color: AppColors.grey,
      ),
    );
  }
}


