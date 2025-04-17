import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/base/base_state.dart';

class AddAddressState extends Equatable {

  final BaseState? getUserLocationOnMap;
  final String? address;
  final String? area;
  final String? city;
  final LatLng? selectedLocation;
  final Set<Marker> markers;
  final BaseState? addAddressState;
  final List<String> localCities;
  final List<String> localAreas;

  const AddAddressState({
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


  AddAddressState copyWith({
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
    return AddAddressState(
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
    getUserLocationOnMap,
    address,
    area,
    city,
    selectedLocation,
    addAddressState,
    markers,
    localCities,
    localAreas,
  ];
}
