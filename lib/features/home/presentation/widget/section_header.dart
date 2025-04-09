// features/home/presentation/widget/section_header.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/occasion/presentation/pages/occasion_page.dart';

import 'package:flower_app/features/home/domain/entities/product_entity.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/features/home/presentation/cubit/home_cubit.dart';

//////its for name of the section and the viewAll ubderline text
class SectionHeader extends StatelessWidget {
  final String title;

  final void Function()? onViewAllTap;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: getMediumStyle(
            color: AppColors.black,
            fontSize: 18.sp,
          ),
        ),

        TextButton(
          onPressed: onViewAllTap,

  

          child: Text(
            'home.sections.view_all'.tr(),
            style: getTextUnderLine(
              color: AppColors.primary,
              fontSize: 14.sp,
            ),
          ),
        )
      ],
    );
  }
}
