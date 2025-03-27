// features/auth/presentation/pages/login_page.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/core/utils/validator.dart';
import 'package:flower_app/core/widget/dialog_utils.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flower_app/features/auth/presentation/widget/remember_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/gestures.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final AuthCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<AuthCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        //----------------------------------------appBar
        appBar: AppBar(
          title: Text('auth.login.title'.tr()),
          automaticallyImplyLeading: false,
        ),
        //----------------------------------------body
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.signInState is BaseSuccessState) {
              Navigator.pushReplacementNamed(context, Routes.home);
            } else if (state.signInState is BaseErrorState) {
              final errorState = state.signInState as BaseErrorState;
              Log.e('Error during sign in: ${errorState.errorMessage}');
              GetIt.I<DialogUtils>().showSnackBar(
                message: 'auth.errors.invalid_credentials'.tr(),
                textColor: AppColors.error,
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state.signInState is BaseLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        ///email
                        TextFormField(
                          controller: cubit.loginemailController,
                          validator: Validator.emailValidate,
                          autofillHints: const [AutofillHints.email],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'auth.login.email.label'.tr(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'auth.login.email.hint'.tr(),
                          ),
                        ),
                        SizedBox(height: 24.h),

                        ///password
                        TextFormField(
                          controller: cubit.loginpasswordController,
                          obscureText: true,
                          validator: Validator.passwordValidation,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'auth.login.password.label'.tr(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'auth.login.password.hint'.tr(),
                          ),
                        ),
                        SizedBox(height: 24.h),

                        ///rememberMe -- forgotPassword
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ////rememberMe
                            const RememberMe(),

                            ///forgotPassword
                            TextButton(
                              onPressed: () {
                                //navigate to forgot password page
                                debugPrint('navigate to forgot password page');
                              },
                              child: Text(
                                'auth.login.forgot_password'.tr(),
                                style: getTextUnderLine(
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 48.h),

                        ///login button
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              cubit.signIn();
                            }
                          },
                          child: Text('auth.login.login_button'.tr()),
                        ),
                        SizedBox(height: 16.h),

                        ///login as guest
                        OutlinedButton(
                          child: Text('auth.login.guest_button'.tr()),
                          onPressed: () {
                            cubit.signInAsGuest();
                            Navigator.pushReplacementNamed(
                                context, Routes.login);
                          },
                        ),
                        SizedBox(height: 16.h),

                        ///dont have account
                        RichText(
                          text: TextSpan(
                              style: getRegularStyle(
                                  color: AppColors.black, fontSize: 14.sp),
                              children: [
                                TextSpan(text: 'auth.login.no_account'.tr()),
                                TextSpan(
                                  text: 'auth.login.sign_up'.tr(),
                                  style: getTextUnderLine(
                                      color: AppColors.primary,
                                      fontSize: 14.sp),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //navigate to sign up page
                                      debugPrint('navigate to sign up page');
                                    },
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
