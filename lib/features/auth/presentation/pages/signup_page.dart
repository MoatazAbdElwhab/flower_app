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
        title: const Text('Sign Up'),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios_rounded,
          ),
          onTap: () {
            Navigator.pop(context);
          },
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
                    title: const Center(child: Text('Error')),
                    content: Text(
                        (state.signUpState as BaseErrorState).errorMessage),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                        },
                        child: const Text('OK'),
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
                builder: (context) {
                  return AlertDialog(
                    title: const Center(child: Text('Created Successfully')),
                    content: const Text(
                      'Account created successfully \n Click OK to login.',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacementNamed(context, Routes.login);
                        },
                        child: const Text('OK'),
                      ),
                    ],
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
                              validator: (value) {
                                return Validator.firstNameValidation(value);
                              },
                              controller: authCubit.firstNameController,
                              decoration: const InputDecoration(
                                  hintText: 'Enter First Name',
                                  labelText: 'First Name'),
                            ),
                          ),
                          SizedBox(
                            width: 17.w,
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                return Validator.lastNameValidation(value);
                              },
                              controller: authCubit.lastNameController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Last Name',
                                labelText: 'Last Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextFormField(
                          validator: (value) {
                            return Validator.emailValidate(value);
                          },
                          controller: authCubit.emailController,
                          decoration: const InputDecoration(
                              hintText: 'Enter Email', labelText: 'Email')),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                return Validator.passwordValidation(value);
                              },
                              controller: authCubit.passwordController,
                              decoration: const InputDecoration(
                                  hintText: 'Enter Password',
                                  labelText: 'Password',
                                 ),
                            ),
                          ),
                          SizedBox(
                            width: 17.w,
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) => Validator.confirmPasswordValidation(value, authCubit.passwordController.text),
                              controller: authCubit.confirmPasswordController,
                              decoration: const InputDecoration(
                                  hintText: 'Confirm Password',
                                  labelText: 'Confirm Password'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextFormField(
                        validator: (value) {
                          return Validator.phoneNumberValidation(value);
                        },
                        controller: authCubit.phoneController,
                        onChanged: (value) => authCubit.enforceEgyptianPrefix(authCubit.phoneController),
                        decoration: const InputDecoration(
                            hintText: 'Enter Phone Number',
                            labelText: 'Phone Number'),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(valueListenable: authCubit.selectedGenderNotifier, builder:(context, genderValue, child) {
                  return Row(
                    children: [
                      Text(
                        "Gender",
                        style: getMediumStyle(
                            color: AppColors.grey, fontSize: 18.sp),
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
                            const Text('Female'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: 'male',
                              onChanged: (String? value) {
                                authCubit.selectGender(value?? '');
                              },
                              groupValue: genderValue,
                            ),
                            const Text('Male'),
                          ],
                        ),
                      ),
                    ],
                  );
                },),
                SizedBox(height: 16.h),
                FittedBox(
                  child: Row(
                    children: [
                      Text(
                        'Creating an account, you agree to our',
                        style: getRegularStyle(
                          color: AppColors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Terms & Conditions",
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
                  child: const Text('Sign Up'),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.login, (route) => false);
                      },
                      child:  Text(
                        "Login",
                        style: getTextUnderLine(color: AppColors.primary, fontSize: 14.sp),
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
