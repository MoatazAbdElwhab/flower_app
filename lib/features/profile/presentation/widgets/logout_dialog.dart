import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/core/widget/dialog_utils.dart';
import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key, this.cubit});
  final ProfileCubit? cubit;
  @override
  Widget build(BuildContext context) {
    cubit!.logout;
    return Dialog(
      backgroundColor: AppColors.scaffoldBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(26.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.profile_logoutTitle.tr(),
              style: getExtraBoldStyle(
                color: AppColors.black,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              LocaleKeys.profile_confirmLogout.tr(),
              style: getRegularStyle(
                color: AppColors.black,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        LocaleKeys.profile_cancel.tr(),
                        style: getMediumStyle(
                          color: AppColors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () {
                      cubit!.logout();
                    },
                    child: BlocConsumer<ProfileCubit, ProfileState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state.logoutState is BaseErrorState) {
                          Navigator.pop(context);
                          getIt<DialogUtils>().showSnackBar(
                            textColor: AppColors.white,
                            message: (state.logoutState as BaseErrorState)
                                .errorMessage,
                            context: context,
                          );
                        }
                        if (state.logoutState is BaseSuccessState) {
                          Navigator.pushReplacementNamed(context, Routes.login);
                        }
                      },
                      builder: (context, state) {
                        if (state.logoutState is BaseLoadingState) {
                          return const CircularProgressIndicator(
                            color: AppColors.scaffoldBackground,
                          );
                        } else {
                          return Text(
                            LocaleKeys.profile_logout.tr(),
                            style: getMediumStyle(
                              color: AppColors.white,
                              fontSize: 14.sp,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
