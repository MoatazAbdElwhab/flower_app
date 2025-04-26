class AutomaticTax {
  final bool? enabled;
  final dynamic liability;
  final dynamic provider;
  final dynamic status;

  const AutomaticTax({
    this.enabled,
    this.liability,
    this.provider,
    this.status,
  });

  factory AutomaticTax.fromJson(Map<String, dynamic> json) => AutomaticTax(
        enabled: json['enabled'] as bool?,
        liability: json['liability'] as dynamic,
        provider: json['provider'] as dynamic,
        status: json['status'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'liability': liability,
        'provider': provider,
        'status': status,
      };
}
