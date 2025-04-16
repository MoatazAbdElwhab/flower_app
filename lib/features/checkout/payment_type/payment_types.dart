class PaymentMethod {
  final PaymentMethodsType paymentType;
  final String name;

  PaymentMethod({
    required this.paymentType,
    required this.name,
  });
}

enum PaymentMethodsType {
  cash,
  card,
}
