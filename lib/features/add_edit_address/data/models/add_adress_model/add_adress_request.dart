import 'package:json_annotation/json_annotation.dart';

part 'add_adress_request.g.dart';

@JsonSerializable()
class AddAndEditAddressRequest {
  final String street;
  final String phone;
  final String city;

  @JsonKey(name: 'lat')
  final String latValue;

  @JsonKey(name: 'long')
  final String longValue;

  final String username;

  AddAndEditAddressRequest({
    required this.street,
    required this.phone,
    required this.city,
    required this.latValue,
    required this.longValue,
    required this.username,
  });

  factory AddAndEditAddressRequest.fromJson(Map<String, dynamic> json) =>
      _$AddAndEditAddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddAndEditAddressRequestToJson(this);
}
