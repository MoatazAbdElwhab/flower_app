sealed class CheckOutSessionDetails {}

class OnlinePaymentDetails extends CheckOutSessionDetails {
  final String sessionUrl;
  final String successUrl;
  final String cancelUrl;

  OnlinePaymentDetails({
    required this.sessionUrl,
    required this.successUrl,
    required this.cancelUrl,
  });
}

class CashPaymentDetails extends CheckOutSessionDetails {}
