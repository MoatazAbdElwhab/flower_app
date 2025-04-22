sealed class PaymentSuccessResponse {}

class OnlinePaymentSuccess extends PaymentSuccessResponse {
  final String sessionUrl;
  final String successUrl;
  final String cancelUrl;

  OnlinePaymentSuccess({
    required this.sessionUrl,
    required this.successUrl,
    required this.cancelUrl,
  });
}

class CashPaymentSuccess extends PaymentSuccessResponse {}
