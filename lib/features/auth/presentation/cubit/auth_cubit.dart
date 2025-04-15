import 'package:flower_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_impl.dart';
import 'package:flower_app/features/auth/domain/entities/auth_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/signup_request_model.dart';
import '../../domain/ues_case/sign_in_use_case.dart';
import '../../domain/ues_case/signup_use_case.dart';
import '../../domain/ues_case/forget_password_use_case.dart';
import '../../domain/ues_case/verify_reset_code_use_case.dart';
import '../../domain/ues_case/reset_password_use_case.dart';
import '../../domain/ues_case/resend_otp_use_case.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._signupUseCase,
    this._forgetPasswordUseCase,
    this._verifyResetCodeUseCase,
    this._resetPasswordUseCase,
    this.signInUseCase,
    this.localStorageClient,
    this._resendOtpUseCase,
  ) : super(
          AuthState(
            forgetPasswordState: BaseInitialState(),
            verifyResetCodeState: BaseInitialState(),
            signUpState: BaseInitialState(),
            resetPasswordState: BaseInitialState(),
            signInState: BaseInitialState(), // Add initial state for sign in
          ),
        ) {
    _rememberMe =
        localStorageClient.getData('rememberMe')?.toLowerCase() == 'true';
    if (_rememberMe) {
      isUserLoggedIn();
    }
  }

  final SignupUseCase _signupUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final SignInUseCase signInUseCase;
  final LocalStorageClient localStorageClient;
  final ResendOtpUseCase _resendOtpUseCase;

  bool _rememberMe = false;

  // text controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController forgetEmailController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController forgetPasswordController = TextEditingController();
  TextEditingController forgetConfirmPasswordController =
      TextEditingController();

  /// Login Controllers
  final TextEditingController loginemailController = TextEditingController();
  final TextEditingController loginpasswordController = TextEditingController();

  ValueNotifier<String> selectedGenderNotifier = ValueNotifier('');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetEmailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  void setRememberMe(bool value) {
    _rememberMe = value;
    localStorageClient.saveData('rememberMe', value.toString());
  }

  bool get rememberMe => _rememberMe;

  Future<void> signIn() async {
    try {
      emit(AuthState(signInState: BaseLoadingState()));

      final response = await signInUseCase.call(
        loginemailController.text.trim(),
        loginpasswordController.text.trim(),
        _rememberMe,
      );

      if (response.isLeft) {
        emit(AuthState(signInState: BaseErrorState(response.left.toString())));
        return;
      }

      // Create an instance of AuthLocalDataSourceImpl for token handling
      final authLocalDataSource = AuthLocalDataSourceImpl(localStorageClient);
      if (_rememberMe && response.right.token != null) {
        await authLocalDataSource.cacheToken(response.right.token!);
      }

      emit(AuthState(
        signInState: BaseSuccessState(),
        authResponse: response.right,
      ));
    } catch (e) {
      Log.e('SignIn Error: ${e.toString()}');
      emit(AuthState(signInState: BaseErrorState(e.toString())));
    }
  }

  void signInAsGuest() {
    emit(AuthState(
      signInState: BaseSuccessState(),
      authResponse: const AuthResponseEntity(
        message: 'Signed in as guest',
        token: null,
        user: null,
      ),
    ));
  }

  Future<bool> isUserLoggedIn() async {
    try {
      emit(AuthState(signInState: BaseLoadingState()));

      // Create an instance of AuthLocalDataSourceImpl
      final authLocalDataSource = AuthLocalDataSourceImpl(localStorageClient);

      final token = await authLocalDataSource.checkSavedToken();
      if (token != null) {
        emit(AuthState(
          signInState: BaseSuccessState(),
          authResponse: AuthResponseEntity(token: token),
        ));
        return true;
      } else {
        emit(AuthState(signInState: BaseInitialState()));
        return false;
      }
    } catch (e) {
      Log.e('Token check error: ${e.toString()}');
      emit(AuthState(signInState: BaseErrorState(e.toString())));
      return false;
    }
  }

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
        emit(state.copyWith(signUpState: BaseSuccessState()));
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

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    phoneController.dispose();
    lastNameController.dispose();
    forgetEmailController.dispose();
    pinController.dispose();
    forgetPasswordController.dispose();
    forgetConfirmPasswordController.dispose();
    loginemailController.dispose();
    loginpasswordController.dispose();
    selectedGenderNotifier.dispose();
    return super.close();
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
        emit(state.copyWith(resetPasswordState: BaseSuccessState()));
      },
    );
  }
}
