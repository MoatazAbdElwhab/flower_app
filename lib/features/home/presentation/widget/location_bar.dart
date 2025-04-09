// features/home/presentation/widget/location_bar.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationBar extends StatelessWidget {
  const LocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.locationState != current.locationState,
      builder: (context, state) {
        String locationText = 'home.location.select'.tr();
        Color textColor = AppColors.black;

        final HomeCubit cubit = context.read<HomeCubit>();

        if (state.locationState is BaseLoadingState) {
          locationText = 'home.location.finding'.tr();
        } else if (state.locationState is BaseSuccessState &&
            cubit.locationAddress != null) {
          locationText =
              '${'home.location.deliver_to'.tr()} ${cubit.locationAddress}';
        } else if (state.locationState is BaseErrorState) {
          locationText = 'home.location.error'.tr();
          textColor = AppColors.error;
        }

        return GestureDetector(
          onTap: () {
            context.read<HomeCubit>().getUserLocation();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20.sp,
                color: textColor,
              ),
              SizedBox(width: 4.w),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    locationText,
                    style: getRegularStyle(
                      color: textColor,
                      fontSize: 14.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 2.w),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 20.sp,
                    color: AppColors.primary,
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
