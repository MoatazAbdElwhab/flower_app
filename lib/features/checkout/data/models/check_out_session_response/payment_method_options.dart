import 'package:flower_app/features/checkout/data/models/check_out_session_response/card.dart';

class PaymentMethodOptions {
  final Card? card;

  const PaymentMethodOptions({this.card});

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
    return PaymentMethodOptions(
      card: json['card'] == null
          ? null
          : Card.fromJson(json['card'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'card': card?.toJson(),
      };
}
