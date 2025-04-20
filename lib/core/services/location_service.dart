// core/services/location_service.dart
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationService {
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.locality ?? ""}, ${place.administrativeArea ?? ""}"
            .trim();
      }
      throw Exception("Could not find location details");
    } catch (e) {
      throw Exception("Failed to get location: ${e.toString()}");
    }
  }
Future<Map<String, String>> getAddressDetailsFromCoordinates(double lat, double lng) async {
  final placemarks = await placemarkFromCoordinates(lat, lng);
  if (placemarks.isNotEmpty) {
    final place = placemarks.first;
    return {
      'address': "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}",
      'city': place.locality ?? '',
      'area': place.subLocality != null && place.subLocality!.isNotEmpty 
                  ? place.subLocality! 
                  : (place.administrativeArea ?? ''),
    };
  } else {
    throw Exception('No address found');
  }
}
}
