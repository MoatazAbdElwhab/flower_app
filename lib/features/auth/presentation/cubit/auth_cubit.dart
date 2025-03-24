// features/auth/presentation/cubit/auth_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:flower_app/features/auth/data/model/response/sign_in_response/user.dart';
import 'package:flower_app/features/auth/domain/use_case/sign_in_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

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
  }) : super(AuthState(signInState: BaseInitialState())) {
    _rememberMe = localStorageClient.getData('rememberMe')?.toLowerCase() == 'true';
    if (_rememberMe) {
      checkSavedToken();
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
      } else {
        emit(AuthState(
            signInState: BaseSuccessState(data: response.right.user)));
        localStorageClient.saveSecuredData('token', response.right.token!);

        loginemailController.clear();
        loginpasswordController.clear();
      }
    } catch (e) {
      emit(AuthState(
        signInState: BaseErrorState(e.toString()),
      ));
    }
  }

  void signInAsGuest() {
    emit(AuthState(signInState: BaseSuccessState(data: null)));
  }

  Future<void> checkSavedToken() async {
    try {
      final token = await localStorageClient.getSecuredData('token');
      if (token != null) {
        emit(AuthState(signInState: BaseSuccessState()));
      }
    } catch (e) {
      Log.e('Error checking saved token: $e');
    }
  }

  void resetState() {
    _rememberMe = false;
    localStorageClient.deleteData('rememberMe');
    localStorageClient.deleteSecuredData('token');
    emit(AuthState(signInState: BaseInitialState()));
  }

  @override
  Future<void> close() {
    loginemailController.dispose();
    loginpasswordController.dispose();
    Log.i('AuthCubit disposed');
    return super.close();
  }
}
