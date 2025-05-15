import 'package:equatable/equatable.dart';

class LocationData extends Equatable {
  final String lat;
  final String lng;

  const LocationData({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
  };

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      lat: (json['lat'] as String),
      lng: (json['lng'] as String),
    );
  }

  @override
  List<Object?> get props => [lat, lng];
}