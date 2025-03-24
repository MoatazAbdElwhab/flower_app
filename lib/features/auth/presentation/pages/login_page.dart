// features/auth/presentation/pages/login_page.dart

// features/auth/presentation/pages/login_page.dart
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/core/utils/validator.dart';
import 'package:flower_app/core/widget/dialog_utils.dart';
import 'package:flower_app/features/auth/data/model/response/sign_in_response/sign_in_response.dart';
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
        ////-----------------------------------appBar
        appBar: AppBar(
          title: const Text('Login'),
          automaticallyImplyLeading: false,
        ),

        //---------------------------------------body
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            //---------------------------------------block consumer
            child: BlocConsumer<AuthCubit, AuthState>(

              ///listener
              listener: (context, state) {
                if (state.signInState is BaseSuccessState) {
                  //navigate to home page
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.home,
                  );
                } else if (state.signInState is BaseErrorState) {
                  //show error message
                  final errorState = state.signInState as BaseErrorState;
                  Log.e('Error during sign in: ${errorState.errorMessage}');
                  GetIt.I<DialogUtils>().showSnackBar(
                    message: "username or password is incorrect",
                    textColor: AppColors.error,
                    context: context,
                  );
                }
              },
              ///builder
              builder: (context, state) {
                if (state.signInState is BaseLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Form(
                    key: formKey,
                    child: Column(
                      children: [
                        ///email
                        TextFormField(
                          controller: cubit.loginemailController,
                          validator: Validator.emailValidate,
                          autofillHints: const [AutofillHints.email],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'Enter you email',
                          ),
                        ),
                        SizedBox(height: 24.h),

                        ///password
                        TextFormField(
                          controller: cubit.loginpasswordController,
                          obscureText: true,
                          validator: Validator.passwordValidation,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'Enter you password ',
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
                                'Forgot password?',
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
                          child: const Text('Login'),
                        ),
                        SizedBox(height: 16.h),

                        ///signin as guest
                        OutlinedButton(
                          child: const Text('Continue as guest'),
                          onPressed: () {
                            cubit.signInAsGuest();
                            Navigator.pushReplacementNamed(
                                context, Routes.home);
                          },
                        ),
                        SizedBox(height: 16.h),

                        ///dont have account
                        RichText(
                          text: TextSpan(
                              style: getRegularStyle(
                                  color: AppColors.black, fontSize: 14.sp),
                              children: [
                                const TextSpan(
                                    text: 'Don\'t have an account? '),
                                TextSpan(
                                  text: 'Sign up',
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
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
