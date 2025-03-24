import 'package:dartz/dartz.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/auth/domain/ues_case/signup_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/signup_request_model.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
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

  String ? selectedGender;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> signup() async {
    if (selectedGender == null) {
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
        gender: selectedGender?? '',
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
        emit(state.copyWith(
            signUpState: BaseSuccessState<Unit>(data: success)));
      },
    );



  }



  void selectGender(String gender) {
    selectedGenderNotifier.value = gender;
    selectedGender = gender;
  }


}
