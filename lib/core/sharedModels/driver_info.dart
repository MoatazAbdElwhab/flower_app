import 'package:equatable/equatable.dart';

class DriverInfo extends Equatable {
  final String? driverId;
  final String? name;
  final String? phone;
  // final String? image;
  // final String? status;

  const DriverInfo({
    this.driverId = 'Null',
    this.name = 'Null',
    this.phone = 'Null',
    // this.image,
    // this.status,
  });

  Map<String, dynamic> toJson() => {
    'driverId': driverId,
    'name': name,
    'phone': phone,
    // 'image': image,
    // 'status': status,
  };

  factory DriverInfo.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const DriverInfo(
        driverId: 'Null',
        name: 'Null',
        phone: 'Null',
        // status: 'Null',
      );
    }

    return DriverInfo(
      driverId: json['driverId'],
      name: json['name'],
      phone: json['phone'],
      // image: json['image'],
      // status: json['status'],
    );
  }

  @override
  List<Object?> get props => [driverId, name, phone,];
}