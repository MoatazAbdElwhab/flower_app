import '../../../checkout/domain/entities/address.dart';

class UpdateAddressResponse {
  final String message;
  final List<Address> addresses;

  UpdateAddressResponse({
    required this.message,
    required this.addresses,
  });

  factory UpdateAddressResponse.fromJson(Map<String, dynamic> json) {
    return UpdateAddressResponse(
      message: json['message'] ?? '',
      addresses: json['addresses'] != null
          ? (json['addresses'] as List)
          .map((addressJson) => Address.fromJson(addressJson))
          .toList()
          : [],
    );
  }
}