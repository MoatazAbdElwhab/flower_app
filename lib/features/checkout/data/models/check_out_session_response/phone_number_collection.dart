class PhoneNumberCollection {
  final bool? enabled;

  const PhoneNumberCollection({this.enabled});

  factory PhoneNumberCollection.fromJson(Map<String, dynamic> json) {
    return PhoneNumberCollection(
      enabled: json['enabled'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
      };
}
