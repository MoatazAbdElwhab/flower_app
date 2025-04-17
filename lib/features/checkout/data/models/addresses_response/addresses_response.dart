import 'package:flower_app/features/checkout/data/models/addresses_response/address_model.dart';

class AddressesResponse {
  final String? message;
  final List<AddressModel> addresses;

  const AddressesResponse({
    required this.message,
    required this.addresses,
  });

  factory AddressesResponse.fromJson(Map<String, dynamic> json) {
    return AddressesResponse(
      message: json['message'] as String?,
      addresses: (json['addresses'] as List<dynamic>)
          .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'addresses': addresses.map((e) => e.toJson()).toList(),
      };
}
