import 'package:dartz/dartz.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/auth/domain/ues_case/signup_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/cupertino.dart';
// features/auth/presentation/cubit/auth_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_impl.dart';
import 'package:flower_app/features/auth/domain/entities/auth_response_entity.dart';
import 'package:flower_app/features/auth/domain/use_case/sign_in_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/signup_request_model.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final LocalStorageClient localStorageClient;
  bool _rememberMe = false;

  /// Login Controllers
  final TextEditingController loginemailController = TextEditingController();
  final TextEditingController loginpasswordController = TextEditingController();

  AuthCubit({
    required this.signInUseCase,
    required this.localStorageClient,
  }) : super(AuthState(signInState: BaseLoadingState())) {
    _rememberMe =
        localStorageClient.getData('rememberMe')?.toLowerCase() == 'true';
    if (_rememberMe) {
      checkSavedToken();
    } else {
      emit(AuthState(signInState: BaseInitialState()));
    }
  }

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

  Future<void> checkSavedToken() async {
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
      } else {
        emit(AuthState(signInState: BaseInitialState()));
      }
    } catch (e) {
      Log.e('Token check error: ${e.toString()}');
      emit(AuthState(signInState: BaseErrorState(e.toString())));
    }
  }

  @override
  Future<void> close() {
    loginemailController.dispose();
    loginpasswordController.dispose();
    return super.close();
  }
  AuthCubit(this._signupUseCase) : super(const AuthState());
  final SignupUseCase _signupUseCase;

  // text controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  ValueNotifier<String> selectedGenderNotifier = ValueNotifier('');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
}
