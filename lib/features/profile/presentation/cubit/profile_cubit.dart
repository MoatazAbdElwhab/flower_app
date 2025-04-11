// features/profile/presentation/cubit/profile_cubit.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart';
import 'package:flower_app/features/profile/data/models/reset_password/request/profile_reset_password_request.dart';
import 'package:flower_app/features/profile/domain/usecases/reset_password_use_case.dart';
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
  final ResetPasswordUseCase _resetPasswordUseCase;
  final AuthLocalDataSourceContract _authLocalDataSource;

  ProfileCubit(
    this._getUserDataUseCase,
    this._editProfileUseCase,
    this._resetPasswordUseCase,
    this._authLocalDataSource,
  ) : super(const ProfileState()) {
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

  //  ----------------------Reset password ----------------------
  Future<void> profileResetPassword(
      String currentPassword, String newPassword) async {
    emit(state.copyWith(resetPasswordState: BaseLoadingState()));

    if (currentPassword == newPassword) {
      emit(
        state.copyWith(
          resetPasswordState:
              BaseErrorState('profile.reset_password.error.same_password'.tr()),
        ),
      );
      return;
    }

    final request = ProfileResetPasswordRequest(
      password: currentPassword,
      newPassword: newPassword,
    );

    final result = await _resetPasswordUseCase(request);

    if (result.isRight) {
      if (result.right.token != null) {
        await _authLocalDataSource.cacheToken(result.right.token!);
      }
      emit(
        state.copyWith(
          resetPasswordState: BaseSuccessState(data: result.right),
        ),
      );
    } else {
      String errorMessage = result.left.message;

      // Debug the actual error message format
      debugPrint("Password Reset Error: $errorMessage");

      if (errorMessage.toLowerCase().contains('incorrect') ||
          errorMessage.toLowerCase().contains('password') ||
          errorMessage.toLowerCase().contains('error')) {
        // Use our localized error message for incorrect password
        emit(
          state.copyWith(
            resetPasswordState: BaseErrorState(
                'profile.reset_password.error.incorrect_password'.tr()),
          ),
        );
      } else {
        // Fallback to the original error message for other errors
        emit(
          state.copyWith(
            resetPasswordState: BaseErrorState(errorMessage),
          ),
        );
      }
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
    isNotificationEnabled.dispose();
    super.close();
  }
}
