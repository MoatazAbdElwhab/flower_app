import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/base/base_state.dart';

class AddOrEditAddressState extends Equatable {
  final BaseState? getUserLocationOnMap;

  final BaseState? getEditedAddressState;
  final String? addressText;
  final String? area;
  final String? city;
  final LatLng? selectedLocation;
  final Set<Marker> markers;
  final BaseState? addAddressState;
  final List<String> localCities;
  final List<String> localAreas;

  const AddOrEditAddressState({
    this.getUserLocationOnMap,
    this.addressText,
    this.area,
    this.city,
    this.selectedLocation,
    this.addAddressState,
    this.getEditedAddressState,
    this.markers = const <Marker>{},
    this.localCities = const <String>[],
    this.localAreas = const <String>[],
  });

  AddOrEditAddressState copyWith({
    BaseState? getUserLocationOnMap,
    BaseState? getEditedAddressState,
    String? addressText,
    String? area,
    String? city,
    LatLng? selectedLocation,
    Set<Marker>? markers,
    BaseState? addAddressState,
    List<String>? localCities,
    List<String>? localAreas,
  }) {
    return AddOrEditAddressState(
        getUserLocationOnMap: getUserLocationOnMap ?? this.getUserLocationOnMap,
        addressText: addressText ?? this.addressText,
        area: area ?? this.area,
        city: city ?? this.city,
        selectedLocation: selectedLocation ?? this.selectedLocation,
        markers: markers ?? this.markers,
        addAddressState: addAddressState ?? this.addAddressState,
        localCities: localCities ?? this.localCities,
        localAreas: localAreas ?? this.localAreas,
        getEditedAddressState:
            getEditedAddressState ?? this.getEditedAddressState);
  }

  @override
  List<Object?> get props => [
        getUserLocationOnMap,
        addressText,
        area,
        city,
        selectedLocation,
        addAddressState,
        markers,
        localCities,
        localAreas,
      ];
}
