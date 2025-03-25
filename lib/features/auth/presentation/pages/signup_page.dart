import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/validator.dart';
import '../cubit/auth_cubit.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('signUp'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
          tooltip: 'back'.tr(),
        ),
      ),
      body: BlocProvider(
        create: (_) => getIt<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.signUpState is BaseLoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }

            if (state.signUpState is BaseErrorState) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Center(child: Text('dialogs.error.title'.tr())),
                    content: Text(
                        (state.signUpState as BaseErrorState).errorMessage),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('dialogs.error.ok'.tr()),
                      ),
                    ],
                  );
                },
              );
            }

            if (state.signUpState is BaseSuccessState) {
              Navigator.pop(context);

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  // This prevents accessing an invalid `BuildContext` if the widget has been removed.
                  Future.delayed(const Duration(milliseconds: 600 ), () {
                    if (context.mounted) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacementNamed(context, Routes.login);
                    }
                  });
                  return AlertDialog(
                    title: Center(child: Text('dialogs.success.title'.tr())),
                    content: Text(
                      'dialogs.success.message'.tr(),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              );
            }
          },
          builder: (context, state) {
            var authCubit = context.read<AuthCubit>();

            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 24.h,
              ),
              children: [
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: authCubit.formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) =>
                                  Validator.firstNameValidation(value),
                              controller: authCubit.firstNameController,
                              decoration: InputDecoration(
                                hintText: 'firstName.hint'.tr(),
                                labelText: 'firstName.label'.tr(),
                              ),
                            ),
                          ),
                          SizedBox(width: 17.w),
                          Expanded(
                            child: TextFormField(
                              validator: (value) =>
                                  Validator.lastNameValidation(value),
                              controller: authCubit.lastNameController,
                              decoration: InputDecoration(
                                hintText: 'lastName.hint'.tr(),
                                labelText: 'lastName.label'.tr(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        validator: (value) => Validator.emailValidate(value),
                        controller: authCubit.emailController,
                        decoration: InputDecoration(
                          hintText: 'email.hint'.tr(),
                          labelText: 'email.label'.tr(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) =>
                                  Validator.passwordValidation(value),
                              controller: authCubit.passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'password.hint'.tr(),
                                labelText: 'password.label'.tr(),
                              ),
                            ),
                          ),
                          SizedBox(width: 17.w),
                          Expanded(
                            child: TextFormField(
                              validator: (value) =>
                                  Validator.confirmPasswordValidation(
                                      value, authCubit.passwordController.text),
                              controller: authCubit.confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'confirmPassword.hint'.tr(),
                                labelText: 'confirmPassword.label'.tr(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        validator: (value) =>
                            Validator.phoneNumberValidation(value),
                        controller: authCubit.phoneController,
                        onChanged: (value) => authCubit
                            .enforceEgyptianPrefix(authCubit.phoneController),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'phone.hint'.tr(),
                          labelText: 'phone.label'.tr(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: authCubit.selectedGenderNotifier,
                  builder: (context, genderValue, child) {
                    return Row(
                      children: [
                        Text(
                          "gender.label".tr(),
                          style: getMediumStyle(
                            color: AppColors.grey,
                            fontSize: 18.sp,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                value: 'female',
                                groupValue: genderValue,
                                onChanged: (String? value) {
                                  authCubit.selectGender(value ?? '');
                                },
                              ),
                              Text('gender.female'.tr()),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                value: 'male',
                                onChanged: (String? value) {
                                  authCubit.selectGender(value ?? '');
                                },
                                groupValue: genderValue,
                              ),
                              Text('gender.male'.tr()),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 16.h),
                FittedBox(
                  child: Row(
                    children: [
                      Text(
                        'terms.prefix'.tr(),
                        style: getRegularStyle(color: AppColors.black),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "terms.conditions".tr(),
                          style:
                              getMediumStyle(color: AppColors.black).copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48.h),
                ElevatedButton(
                  onPressed: () {
                    if (authCubit.formKey.currentState?.validate() ?? false) {
                      authCubit.signup();
                    }
                  },
                  child: Text('signUpButton'.tr()),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('loginPrompt.prefix'.tr()),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.login,
                          (route) => false,
                        );
                      },
                      child: Text(
                        "loginPrompt.action".tr(),
                        style: getTextUnderLine(
                          color: AppColors.primary,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
