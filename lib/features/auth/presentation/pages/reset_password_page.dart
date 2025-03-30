import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/core/utils/validator.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var authCubit = context.read<AuthCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 16.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.resetPassword_title.tr(),
                      style: getMediumStyle(
                          color: AppColors.black, fontSize: 18.sp),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      LocaleKeys.resetPassword_description.tr(),
                      textAlign: TextAlign.center,
                      style:
                          getLightStyle(color: AppColors.grey, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Column(
                children: [
                  Form(
                    key: authCubit.resetPasswordFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: authCubit.forgetPasswordController,
                          validator: Validator.passwordValidation,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.password_label.tr(),
                            hintText: LocaleKeys.password_hint.tr(),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(height: 24.h),
                        TextFormField(
                          controller: authCubit.forgetConfirmPasswordController,
                          validator: (val) =>
                              Validator.confirmPasswordValidation(
                                  val, authCubit.forgetPasswordController.text),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.confirmPassword_label.tr(),
                            hintText: LocaleKeys.confirmPassword_hint.tr(),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 48.h),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: authCubit,
                    listener: (context, state) {
                      if (state.resetPasswordState is BaseSuccessState) {
                        Navigator.pushNamed(context, Routes.navbar);
                      } else if (state.resetPasswordState is BaseErrorState) {
                        final errorMessage =
                            (state.resetPasswordState as BaseErrorState)
                                .errorMessage;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMessage),
                            backgroundColor: AppColors.error,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (state.resetPasswordState is BaseLoadingState) {
                            return;
                          }
                          if (authCubit.resetPasswordFormKey.currentState
                                  ?.validate() ??
                              false) {
                            authCubit.resetPassword(
                              authCubit.forgetEmailController.text,
                              authCubit.forgetPasswordController.text,
                            );
                          } else {
                            null;
                          }
                        },
                        child: state.resetPasswordState is BaseLoadingState
                            ? const CircularProgressIndicator(
                                color: AppColors.white)
                            : Text(LocaleKeys.resetPassword_resetButton.tr()),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
