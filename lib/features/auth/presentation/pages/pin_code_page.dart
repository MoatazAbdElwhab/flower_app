import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_resend_timer/otp_resend_timer.dart';
import 'package:pinput/pinput.dart';

class PinCodePage extends StatelessWidget {
  const PinCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text("Password")),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 16.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Column(
                children: [
                  Text(
                    LocaleKeys.pinCode_title.tr(),
                    style:
                        getMediumStyle(color: AppColors.black, fontSize: 18.sp),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    LocaleKeys.pinCode_description.tr(),
                    textAlign: TextAlign.center,
                    style:
                        getLightStyle(color: AppColors.grey, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            BlocConsumer<AuthCubit, AuthState>(
              listenWhen: (previous, current) {
                if (previous.verifyResetCodeState is BaseLoadingState ||
                    current.verifyResetCodeState is BaseLoadingState) {
                  return true;
                }
                return false;
              },
              listener: (context, state) {
                if (state.verifyResetCodeState is BaseSuccessState) {
                  Navigator.pushNamed(context, Routes.resetPassword);
                } else if (state.verifyResetCodeState is BaseErrorState) {
                  authCubit.pinController.clear();
                }
              },
              buildWhen: (previous, current) {
                if (previous.verifyResetCodeState is BaseLoadingState ||
                    current.verifyResetCodeState is BaseLoadingState) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                final hasError = state.verifyResetCodeState is BaseErrorState;
                final errorMessage = hasError
                    ? (state.verifyResetCodeState as BaseErrorState)
                        .errorMessage
                    : null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Pinput(
                      length: 6,
                      controller: authCubit.pinController,
                      keyboardType: TextInputType.number,
                      showCursor: true,
                      pinAnimationType: PinAnimationType.fade,
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      defaultPinTheme:
                          hasError ? _errorPinTheme() : _pinTheme(),
                      focusedPinTheme: _focusedPinTheme(),
                      submittedPinTheme: _focusedPinTheme(),
                      onCompleted: (pin) {
                        authCubit.verifyResetCode(pin);
                        authCubit.pinController.clear();
                      },
                    ),
                    if (hasError)
                      Padding(
                        padding: EdgeInsetsDirectional.only(top: 8.h, end: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(Icons.error_outline,
                                color: AppColors.error, size: 18),
                            SizedBox(width: 4.w),
                            Text(
                              errorMessage ??
                                  LocaleKeys.pinCode_ErrorMessage.tr(),
                              style: getLightStyle(color: AppColors.error),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
            SizedBox(height: 24.h),
            Center(
              child: OtpResendTimer(
                controller: OtpResendTimerController(initialTime: 60),
                onResendClicked: () {
                  authCubit.resendOtp();
                  authCubit.pinController.clear();
                },
                autoStart: true,
                readyMessage: LocaleKeys.pinCode_ReadyMessage.tr(),
                resendMessage: LocaleKeys.pinCode_ResendMessage.tr(),
                timerMessageStyle:
                    getMediumStyle(color: AppColors.primary, fontSize: 12.sp),
                resendMessageStyle:
                    getRegularStyle(color: AppColors.primary, fontSize: 16.sp),
                readyMessageStyle:
                    getRegularStyle(color: AppColors.black, fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PinTheme _pinTheme() => PinTheme(
        width: 50.w,
        height: 50.h,
        textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        decoration: BoxDecoration(
          color: AppColors.disableButton,
          borderRadius: BorderRadius.circular(10),
        ),
      );

  PinTheme _focusedPinTheme() => PinTheme(
        width: 50.w,
        height: 50.h,
        textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.primary, width: 1),
        ),
      );

  PinTheme _errorPinTheme() => PinTheme(
        width: 50.w,
        height: 50.h,
        textStyle: TextStyle(
            fontSize: 20.sp,
            color: AppColors.error,
            fontWeight: FontWeight.bold),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.error, width: 1),
        ),
      );
}
