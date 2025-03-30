import 'package:dartz/dartz.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/auth/domain/ues_case/forget_password_use_case.dart';
import 'package:flower_app/features/auth/domain/ues_case/resend_otp_use_case.dart';
import 'package:flower_app/features/auth/domain/ues_case/reset_password_use_case.dart';
import 'package:flower_app/features/auth/domain/ues_case/signup_use_case.dart';
import 'package:flower_app/features/auth/domain/ues_case/verify_reset_code_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/signup_request_model.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._signupUseCase,
    this._forgetPasswordUseCase,
    this._verifyResetCodeUseCase,
    this._resetPasswordUseCase,
    this._resendOtpUseCase,
  ) : super(AuthState(
          forgetPasswordState: BaseInitialState(),
          verifyResetCodeState: BaseInitialState(),
          signUpState: BaseInitialState(),
          resetPasswordState: BaseInitialState(),
        ));
  final SignupUseCase _signupUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final ResendOtpUseCase _resendOtpUseCase;

  // text controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  final TextEditingController forgetEmailController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  TextEditingController forgetPasswordController = TextEditingController();
  TextEditingController forgetConfirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> forgetEmailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();


  ValueNotifier<String> selectedGenderNotifier = ValueNotifier('');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // signup
  Future<void> signup() async {
    if (selectedGenderNotifier.value.isEmpty) {
      emit(state.copyWith(
          signUpState: BaseErrorState("Please select a gender")));
      return;
    }

    emit(state.copyWith(signUpState: BaseLoadingState()));

    final response = await _signupUseCase.call(
      SignUpRequestModel(
        email: emailController.text,
        rePassword: confirmPasswordController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: phoneController.text,
        gender: selectedGenderNotifier.value,
      ),
    );

    response.fold(
      (error) async {
        emit(
          state.copyWith(
            signUpState: BaseErrorState(error.message),
          ),
        );
      },
      (success) {
        emit(
            state.copyWith(signUpState: BaseSuccessState<Unit>(data: success)));
      },
    );
  }


  // forget password
  Future<void> forgetPassword() async {
    emit(state.copyWith(forgetPasswordState: BaseLoadingState()));
    final response =
        await _forgetPasswordUseCase.call(forgetEmailController.text);

    response.fold(
      (error) async {
        emit(
          state.copyWith(
            forgetPasswordState: BaseErrorState(error.message),
          ),
        );
      },
      (success) {
        emit(state.copyWith(forgetPasswordState: BaseSuccessState()));
      },
    );
  }


  // this function is to enforce the egyptian prefix {+2} on the phone number
  void enforceEgyptianPrefix(TextEditingController controller) {
    if (!controller.text.startsWith("+2")) {
      controller.text = "+2"; // Reset if deleted
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    }
  }

  void selectGender(String gender) {
    selectedGenderNotifier.value = gender;
  }


  Future<void> verifyResetCode(String resetCode) async {
    emit(state.copyWith(verifyResetCodeState: BaseLoadingState()));
    final response = await _verifyResetCodeUseCase.call(resetCode);
    response.fold(
      (error) async {
        emit(
          state.copyWith(
            verifyResetCodeState: BaseErrorState(error.message),
          ),
        );
      },
      (success) {
        emit(state.copyWith(verifyResetCodeState: BaseSuccessState()));
      },
    );
  }

  Future<void> resendOtp() async {
    await _resendOtpUseCase.call(forgetEmailController.text);
  }

  Future<void> resetPassword(String email, String newPassword) async {
    emit(state.copyWith(resetPasswordState: BaseLoadingState()));
    final response = await _resetPasswordUseCase.call(email, newPassword);
    response.fold(
      (error) async {
        emit(
          state.copyWith(
            resetPasswordState: BaseErrorState(error.message),
          ),
        );
      },
      (success) {
        emit(state.copyWith(
            resetPasswordState: BaseSuccessState<Unit>(data: success)));
      },
    );
  }

}
