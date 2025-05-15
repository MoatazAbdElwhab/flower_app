import 'package:equatable/equatable.dart';

import 'location_data.dart';

class PickUPAddress extends Equatable {
  final String title;
  final String address;
  final LocationData location;

  const PickUPAddress({
    required this.title,
    required this.address,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'address': address,
    'location': location.toJson(),
  };

  factory PickUPAddress.fromJson(Map<String, dynamic> json) {
    return PickUPAddress(
      title: json['title'] ?? '',
      address: json['address'] ?? '',
      location: LocationData.fromJson(json['location']),
    );
  }

  @override
  List<Object?> get props => [title, address, location];
}