class PaymentMethodConfigurationDetails {
  final String? id;
  final dynamic parent;

  const PaymentMethodConfigurationDetails({this.id, this.parent});

  factory PaymentMethodConfigurationDetails.fromJson(
      Map<String, dynamic> json) {
    return PaymentMethodConfigurationDetails(
      id: json['id'] as String?,
      parent: json['parent'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'parent': parent,
      };
}
