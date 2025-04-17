import 'package:json_annotation/json_annotation.dart';

part 'add_adress_request.g.dart';

@JsonSerializable()
class AddAdressRequest {
  final String street;
  final String phone;
  final String city;

  @JsonKey(name: 'lat')
  final String latValue;

  @JsonKey(name: 'long')
  final String longValue;

  final String username;

  AddAdressRequest({
    required this.street,
    required this.phone,
    required this.city,
    required this.latValue,
    required this.longValue,
    required this.username,
  });

  factory AddAdressRequest.fromJson(Map<String, dynamic> json) =>
      _$AddAdressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddAdressRequestToJson(this);
}
