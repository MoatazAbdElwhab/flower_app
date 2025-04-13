import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/profile/domain/usecases/edit_profile_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/get_user_data_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/update_profile_data/update_profile_request.dart';
import '../../domain/entities/user_data.dart';
part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetUserDataUseCase _getUserDataUseCase;
  final EditProfileUseCase _editProfileUseCase;

  ProfileCubit(this._getUserDataUseCase, this._editProfileUseCase)
      : super(const ProfileState()) {
    getUserData();
  }

  final ValueNotifier<bool> isNotificationEnabled = ValueNotifier(false);
   // text controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  // form keys
  final GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();

  // ValueNotifier<String> updateUserGender = ValueNotifier('');
  String userGender = '';
  Future<void> getUserData() async {
    emit(state.copyWith(getUserDataState: BaseLoadingState()));
    final result = await _getUserDataUseCase();
    result.fold(
      (error) => emit(
        state.copyWith(
          getUserDataState: BaseErrorState(error.toString()),
        ),
      ),
      (data) => emit(
        state.copyWith(
          getUserDataState: BaseSuccessState(data: data),
          userData: data,
        ),
      ),
    );
  }

  void changeNotification() {
    isNotificationEnabled.value = !isNotificationEnabled.value;
  }
  //  ----------------------edit profile ----------------------
  //  void updateProfileGender(String gender) {
  //   updateUserGender.value = gender;
  // }

  Future<void> updateProfileData() async {
    emit(state.copyWith(editProfileState: BaseLoadingState()));
    final result = editProfileFormKey.currentState!.validate()
        ? await _editProfileUseCase(UpdateProfileRequest(
            email: emailController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            phone: phoneController.text,
          ))
        : null;
    if (result != null) {
      result.fold(
        (error) => emit(
          state.copyWith(
            editProfileState: BaseErrorState(error.toString()),
          ),
        ),
        (success) => emit(
          state.copyWith(
            editProfileState: BaseSuccessState<void>(),
          ),
        ),
      );
    }
  }

  void initEditProfileData(UserData? userData) {
    emailController.text = userData?.email ?? '';
    firstNameController.text = userData?.firstName ?? '';
    lastNameController.text = userData?.lastName ?? '';
    phoneController.text = userData?.phone ?? '';
    userGender = userData?.gender ?? '';
    passwordController.text = '********';
  }

  @override
  Future<void> close() async {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    phoneController.dispose();
    lastNameController.dispose();
    // updateUserGender.dispose();
    super.close();
  }
}
