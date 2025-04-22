
class Address {
  final String id;
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String username;

  const Address({
    required this.id,
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? json['_id'] ?? '',
      street: json['street'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
      lat: json['lat'] ?? '',
      long: json['long'] ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'phone': phone,
      'city': city,
      'lat': lat,
      'long': long,
      'username': username,
    };
  }
  @override
  String toString() {
    return 'Address(id: $id, street: $street, phone: $phone, city: $city, lat: $lat, long: $long, username: $username)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Address &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          street == other.street &&
          phone == other.phone &&
          city == other.city &&
          lat == other.lat &&
          long == other.long &&
          username == other.username;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      street.hashCode ^
      phone.hashCode ^
      city.hashCode ^
      lat.hashCode ^
      long.hashCode ^
      username.hashCode;
}
