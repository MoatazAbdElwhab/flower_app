
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/services/location_service.dart';
import '../../data/models/add_adress_model/add_adress_request.dart';
import '../../domain/use_cases/add_adress_use_case.dart';
import 'add_address_state.dart';

@injectable
class AddAddressCubit extends Cubit<AddAddressState> {
  final LocationService locationService;
  final AddAddressUseCase _addAdressUseCase;
  AddAddressCubit(this.locationService, this._addAdressUseCase) : super(const AddAddressState());

  // add address Controllers
  final TextEditingController addressController = TextEditingController();
  final TextEditingController recipientNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final GlobalKey<FormState> saveAdressFormKey = GlobalKey<FormState>();


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
