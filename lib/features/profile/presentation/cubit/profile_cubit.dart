// features/profile/presentation/cubit/profile_cubit.dart
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/services/location_service.dart';
import 'package:flower_app/core/utils/validator.dart';
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart';
import 'package:flower_app/features/profile/data/models/add_adress_model/add_adress_request.dart';
import 'package:flower_app/features/profile/data/models/reset_password/request/profile_reset_password_request.dart';
import 'package:flower_app/features/profile/domain/usecases/add_adress_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/reset_password_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/edit_profile_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/get_user_data_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/logout_use_case.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  final LocationService locationService;
  final AddAddressUseCase _addAdressUseCase;

  ProfileCubit(
    this._getUserDataUseCase,
    this._editProfileUseCase,
    this._logoutUseCase,
    this._resetPasswordUseCase,
    this._authLocalDataSource,
    this.locationService,
    this._addAdressUseCase,
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
  // add address Controllers
  final TextEditingController addressController = TextEditingController();
  final TextEditingController recipientNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
 
  // form keys
  final GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> saveAdressFormKey = GlobalKey<FormState>();
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

    addressController.dispose();
    recipientNameController.dispose();
    phoneNumberController.dispose();
    areaController.dispose();
    cityController.dispose();
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

  //  ----------------------get user location form map ----------------------
  // add Address Section
  Future<void> getUserPositionFormMap(BitmapDescriptor? icon) async {
    emit(state.copyWith(getUserLocationOnMap: BaseLoadingState()));

    try {
      final position = await locationService.getCurrentPosition();
      final LatLng latLng = LatLng(position.latitude, position.longitude);

      final addressDetails =
          await locationService.getAddressDetailsFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      final marker = Marker(
        markerId: const MarkerId("initial_marker"),
        position: latLng,
        icon: icon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: "Your Location"),
      );

      emit(state.copyWith(
        getUserLocationOnMap: BaseSuccessState(data: position),
        selectedLocation: latLng,
        address: addressDetails['address'],
        city: addressDetails['city'],
        area: addressDetails['area'],
        markers: {marker},
      ));
    } catch (e) {
      emit(state.copyWith(getUserLocationOnMap: BaseErrorState(e.toString())));
    }
  }

  Future<void> updateLocationAndAddress(
      LatLng latLng, BitmapDescriptor? icon) async {
    emit(state.copyWith(getUserLocationOnMap: BaseLoadingState()));

    try {
      final details = await locationService.getAddressDetailsFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      final updatedMarkers = {
        Marker(
          markerId: const MarkerId('selected_marker'),
          position: latLng,
          icon: icon ?? BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(title: 'Location'),
        ),
      };

      emit(state.copyWith(
        getUserLocationOnMap: BaseSuccessState(),
        selectedLocation: latLng,
        markers: updatedMarkers,
        address: details['address'],
        city: details['city'],
        area: details['area'],
      ));
    } catch (e) {
      emit(state.copyWith(
        getUserLocationOnMap: BaseErrorState(e.toString()),
      ));
    }
  }

  Future<void> centerToUserLocation(BitmapDescriptor? icon) async {
    emit(state.copyWith(getUserLocationOnMap: BaseLoadingState()));

    try {
      final pos = await locationService.getCurrentPosition();

      final newLatLng = LatLng(pos.latitude, pos.longitude);
      final updatedMarkers = {
        Marker(
          markerId: const MarkerId('initial_marker'),
          position: newLatLng,
          icon: icon ?? BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(title: 'Your Location'),
        ),
      };

      final details = await locationService.getAddressDetailsFromCoordinates(
        pos.latitude,
        pos.longitude,
      );

      emit(state.copyWith(
        getUserLocationOnMap: BaseSuccessState(data: pos),
        selectedLocation: newLatLng,
        markers: updatedMarkers,
        address: details['address'],
        city: details['city'],
        area: details['area'],
      ));
    } catch (e) {
      emit(state.copyWith(
        getUserLocationOnMap: BaseErrorState(e.toString()),
      ));
    }
  }

  Future<void> saveUserAddress() async {
    final isValid = saveAdressFormKey.currentState!.validate();

    if (!isValid) return;

    final addAddressRequest = AddAdressRequest(
      street: addressController.text,
      phone: phoneNumberController.text,
      city: cityController.text,
      latValue: state.selectedLocation?.latitude.toString() ?? 'Z',
      longValue: state.selectedLocation?.longitude.toString() ?? 'Z',
      username: recipientNameController.text,
    );
    emit(state.copyWith(addAddressState: BaseLoadingState()));

      final result = await _addAdressUseCase.call(addAddressRequest);

      result.fold(
        (error) => emit(
          state.copyWith(addAddressState: BaseErrorState(error.toString())),
        ),
        (success) => emit(
          state.copyWith(addAddressState: BaseSuccessState()),
        ),
      );
    }

    final Map<String, List<String>> _areaCitiesMap = {};

  Future<void> loadAreasAndCities() async {
    final areaJson =
        await rootBundle.loadString('assets/common_locations/area.json');
    final areaParsed = json.decode(areaJson) as List;
    final govData = <Map<String, dynamic>>[];
    for (final obj in areaParsed) {
      if (obj['type'] == 'table' && obj['name'] == 'governorates') {
        govData.addAll(List<Map<String, dynamic>>.from(obj['data']));
      }
    }
    final cityJson =
        await rootBundle.loadString('assets/common_locations/cities.json');
    final cityParsed = json.decode(cityJson) as List;
    final cityData = <Map<String, dynamic>>[];
    for (final obj in cityParsed) {
      if (obj['type'] == 'table' && obj['name'] == 'cities') {
        cityData.addAll(List<Map<String, dynamic>>.from(obj['data']));
      }
    }
    final allAreas = <String>[];
    for (final gov in govData) {
      final govName = gov['governorate_name_en'] as String;
      allAreas.add(govName);
      final govId = gov['id'].toString();
      _areaCitiesMap[govName] = cityData
          .where((c) => c['governorate_id'].toString() == govId)
          .map((c) => c['city_name_en'] as String)
          .toList();
    }
    emit(state.copyWith(localAreas: allAreas));
  }

  void areaChanged(String newArea) {
    areaController.text = newArea;
    final cities = _areaCitiesMap[newArea] ?? [];
    emit(state.copyWith(
      area: newArea,
      city: null,
      localCities: cities,
    ));
  }

  void cityChanged(String newCity) {
    cityController.text = newCity;
    emit(state.copyWith(city: newCity));
  }

}
