import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/utils/validator.dart';
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart';
import 'package:flower_app/features/checkout/domain/entities/address.dart';
import 'package:flower_app/features/profile/data/models/reset_password/request/profile_reset_password_request.dart';
import 'package:flower_app/features/profile/domain/usecases/delete_address_usecase.dart';
import 'package:flower_app/features/profile/domain/usecases/get_user_oders_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/reset_password_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/edit_profile_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/get_user_data_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/logout_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/update_address_usecase.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
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
  final LogoutUseCase _logoutUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final AuthLocalDataSourceContract _authLocalDataSource;
  final UpdateAddressUsecase _updateAddressUsecase;
  final DeleteAddressUsecase _deleteAddressUsecase;
  final GetUserOdersUseCase _getUserOdersUseCase;

  ProfileCubit(
    this._getUserDataUseCase,
    this._editProfileUseCase,
    this._logoutUseCase,
    this._resetPasswordUseCase,
    this._authLocalDataSource,
    this._updateAddressUsecase,
    this._deleteAddressUsecase,
    this._getUserOdersUseCase,
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
    if (!_validatePasswordsBeforeSubmit(currentPassword, newPassword)) {
      return;
    }
    emit(state.copyWith(resetPasswordState: BaseLoadingState()));

    final request = ProfileResetPasswordRequest(
      password: currentPassword,
      newPassword: newPassword,
    );
    final result = await _resetPasswordUseCase(request);
    _handleResetPasswordResult(result);
  }

  void initEditProfileData(UserData? userData) {
    emailController.text = userData?.email ?? '';
    firstNameController.text = userData?.firstName ?? '';
    lastNameController.text = userData?.lastName ?? '';
    phoneController.text = userData?.phone ?? '';
    userGender = userData?.gender ?? '';
    passwordController.text = '********';
  }

  Future<void> logout() async {
    emit(state.copyWith(logoutState: BaseLoadingState()));
    final result = await _logoutUseCase();
    result.fold(
      (error) {
        emit(state.copyWith(logoutState: BaseErrorState(error.toString())));
      },
      (success) {
        emit(state.copyWith(logoutState: BaseSuccessState()));
      },
    );
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

  bool _validatePasswordsBeforeSubmit(
      String currentPassword, String newPassword) {
    if (currentPassword == newPassword) {
      emit(
        state.copyWith(
          resetPasswordState: BaseErrorState(
              LocaleKeys.profile_reset_password_error_same_password.tr()),
        ),
      );
      return false;
    }
    return true;
  }

  void _handleResetPasswordResult(dynamic result) {
    if (result.isRight) {
      if (result.right.token != null) {
        _authLocalDataSource.cacheToken(result.right.token!);
      }
      emit(
        state.copyWith(
          resetPasswordState: BaseSuccessState(data: result.right),
        ),
      );
    } else {
      _handleResetPasswordError(result.left.message);
    }
  }

  void _handleResetPasswordError(String errorMessage) {
    final String userFacingErrorMessage =
        _getPasswordErrorMessage(errorMessage);
    emit(
      state.copyWith(
        resetPasswordState: BaseErrorState(userFacingErrorMessage),
      ),
    );
  }

  String _getPasswordErrorMessage(String apiErrorMessage) {
    final lowerCaseError = apiErrorMessage.toLowerCase();

    if (lowerCaseError.contains('incorrect') ||
        lowerCaseError.contains('password') ||
        lowerCaseError.contains('error')) {
      return LocaleKeys.profile_reset_password_error_incorrect_password.tr();
    }
    return apiErrorMessage;
  }

  void updateResetPasswordFormValidity({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    bool? isValid,
  }) {
    if (isValid != null) {
      emit(state.copyWith(isResetPasswordFormValid: isValid));
      return;
    }
    final currentPasswordValid =
        Validator.passwordValidation(currentPassword ?? '') == null;
    final newPasswordValid =
        Validator.passwordValidation(newPassword ?? '') == null;
    final confirmPasswordFilled = (confirmPassword ?? '').isNotEmpty;
    final passwordsMatch = newPassword == confirmPassword;

    final formValid = currentPasswordValid &&
        newPasswordValid &&
        confirmPasswordFilled &&
        passwordsMatch;

    emit(state.copyWith(isResetPasswordFormValid: formValid));
  }

  Future<void> onDeleteAddress(String id) async {
    emit(state.copyWith(deleteAddressState: BaseLoadingState(),activeAddressId: id));
    try {
      await _deleteAddressUsecase(id);
      final updatedUserData = state.userData;
      updatedUserData!.addresses!.removeWhere((address) => address.id == id);
      emit(state.copyWith(
          deleteAddressState: BaseSuccessState(), userData: updatedUserData));
    } catch (e) {
      emit(state.copyWith(deleteAddressState: BaseErrorState(e.toString())));
    }
  }

  Future<void> onUpdateAddress(Address address) async {
    emit(state.copyWith(updateAddressState: BaseLoadingState()));
    try {
      final newAddresses = await _updateAddressUsecase(address);
      emit(state.copyWith(
          updateAddressState: BaseSuccessState(),
          userData: state.userData!.copyWith(addresses: newAddresses)));
      await getUserData();
    } catch (e) {
      emit(state.copyWith(updateAddressState: BaseErrorState(e.toString())));
    }
  }

//  ----------------------User Orders ----------------------
Future<void> getUserOrders() async {
  emit(state.copyWith(getUserOrdersState: BaseLoadingState()));
  var result = await _getUserOdersUseCase();
  result.fold(
    (error) => emit(
      state.copyWith(
        getUserOrdersState: BaseErrorState(error.toString()),
      ),
    ),
    (data) => emit(
        state.copyWith(
          getUserOrdersState: BaseSuccessState(data: data),
        ),
      ),
  );
}
}
