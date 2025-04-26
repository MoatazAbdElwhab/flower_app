import 'package:flower_app/features/checkout/data/models/check_out_session_response/session.dart';
import 'package:flower_app/features/checkout/data/models/payment_success_response.dart';

class CheckOutSessionResponse extends OnlinePaymentSuccess {
  final String? message;
  final Session? session;

  CheckOutSessionResponse({
    this.message,
    this.session,
  }) : super(
          sessionUrl: session?.url ?? '',
          successUrl: session?.successUrl ?? '',
          cancelUrl: session?.cancelUrl ?? '',
        );

  factory CheckOutSessionResponse.fromJson(Map<String, dynamic> json) {
    return CheckOutSessionResponse(
      message: json['message'] as String?,
      session: json['session'] == null
          ? null
          : Session.fromJson(json['session'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'session': session?.toJson(),
      };
}
