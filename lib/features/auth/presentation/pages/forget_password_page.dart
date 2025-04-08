// features/auth/presentation/pages/forget_password_page.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/core/utils/validator.dart';
import 'package:flower_app/core/widget/dialog_utils.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flower_app/generated/locale_keys.g.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

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
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Column(
                  children: [
                    Text(
                      'forgetPassword.title'.tr(),
                      //LocaleKeys.forgetPassword_title.tr(),

                      style: getMediumStyle(
                          color: AppColors.black, fontSize: 18.sp),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'forgetPassword.description'.tr(),
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
                    key: context.read<AuthCubit>().forgetEmailFormKey,
                    child: TextFormField(
                      controller:
                          context.read<AuthCubit>().forgetEmailController,
                      validator: Validator.emailValidate,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        //labelText: LocaleKeys.email_label.tr(),
                        //hintText: LocaleKeys.email_hint.tr(),
                        labelText: 'Email',
                        hintText: 'E-mail',
                      ),
                    ),
                  ),
                  SizedBox(height: 48.h),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: authCubit,
                    listenWhen: (previous, current) {
                      if (previous.forgetPasswordState is BaseLoadingState ||
                          current.forgetPasswordState is BaseLoadingState) {
                        return true;
                      }
                      return false;
                    },
                    listener: (context, state) {
                      if (state.forgetPasswordState is BaseSuccessState) {
                        Navigator.pushNamed(context, Routes.pinCode);
                      } else if (state.forgetPasswordState is BaseErrorState) {
                        final errorMessage =
                            (state.forgetPasswordState as BaseErrorState)
                                .errorMessage;
                        getIt<DialogUtils>().showSnackBar(textColor: AppColors.error,
                            message: errorMessage, context: context);
                      }
                    },
                    buildWhen: (previous, current) {
                      if (previous.forgetPasswordState is BaseLoadingState ||
                          current.forgetPasswordState is BaseLoadingState) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (state.forgetPasswordState is BaseLoadingState) {
                            return;
                          }
                          if (authCubit.forgetEmailFormKey.currentState
                                  ?.validate() ??
                              false) {
                            authCubit.forgetPassword();
                          } else {
                            null;
                          }
                        },
                        child: state.forgetPasswordState is BaseLoadingState
                            ? const CircularProgressIndicator(
                                color: AppColors.white)
                            : Text(
                                // LocaleKeys.forgetPassword_continueButton.tr()),
                                'forgetPassword.continueButton'.tr(),
                              ),
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
