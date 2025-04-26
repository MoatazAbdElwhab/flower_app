import 'package:flower_app/features/checkout/data/models/create_cash_order_response/order.dart';
import 'package:flower_app/features/checkout/data/models/payment_success_response.dart';

class CreateCashOrderResponse extends CashPaymentSuccess {
  final String? message;
  final Order? order;

  CreateCashOrderResponse({
    this.message,
    this.order,
  });

  factory CreateCashOrderResponse.fromJson(Map<String, dynamic> json) {
    return CreateCashOrderResponse(
      message: json['message'] as String?,
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'order': order?.toJson(),
      };
}
