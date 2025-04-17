// features/profile/presentation/cubit/profile_state.dart
part of 'profile_cubit.dart';

class ProfileState extends Equatable {

  const ProfileState({
    this.getUserDataState, 
    this.editProfileState,
    this.logoutState,
    this.resetPasswordState,
    this.userData,
    this.isResetPasswordFormValid = false,
    this.getUserLocationOnMap,
    this.address,
    this.area,
    this.city,
    this.selectedLocation,
    this.addAddressState,
    this.markers = const <Marker>{},
    this.localCities = const <String>[],
    this.localAreas = const <String>[],
  });

  final BaseState? getUserDataState;
  final BaseState? editProfileState;
    final UserData? userData;
  final BaseState? logoutState;
  final BaseState? resetPasswordState;
  final bool isResetPasswordFormValid;
  final BaseState? getUserLocationOnMap;
  final String? address;
  final String? area;
  final String? city;
  final LatLng? selectedLocation;
  final Set<Marker> markers;
  final BaseState? addAddressState;
  final List<String> localCities;
  final List<String> localAreas;

  ProfileState copyWith({
    BaseState? getUserDataState,
    BaseState? editProfileState,
    BaseState? logoutState,
    BaseState? resetPasswordState,
    UserData? userData,
    bool? isResetPasswordFormValid,
    BaseState? getUserLocationOnMap,
    String? address,
    String? area,
    String? city,
    LatLng? selectedLocation,
    Set<Marker>? markers,
    BaseState? addAddressState,
    List<String>? localCities,
    List<String>? localAreas,
  }) {
    return ProfileState(
      getUserDataState: getUserDataState ?? this.getUserDataState,
      editProfileState: editProfileState ?? this.editProfileState,
      logoutState: logoutState ?? this.logoutState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      isResetPasswordFormValid:
          isResetPasswordFormValid ?? this.isResetPasswordFormValid,
      userData: userData ?? this.userData,
      getUserLocationOnMap: getUserLocationOnMap ?? this.getUserLocationOnMap,
      address: address ?? this.address,
      area: area ?? this.area,
      city: city ?? this.city,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      markers: markers ?? this.markers,
      addAddressState: addAddressState ?? this.addAddressState,
      localCities: localCities ?? this.localCities,
      localAreas: localAreas ?? this.localAreas,
    );
  }

  @override
  List<Object?> get props => [
        getUserDataState,
        editProfileState,
        logoutState,
        resetPasswordState,
        isResetPasswordFormValid,
        getUserLocationOnMap,
        address,
        area,
        city,
        selectedLocation,
        markers,
        addAddressState,
        userData,
        localCities,
        localAreas,
      ];
}
