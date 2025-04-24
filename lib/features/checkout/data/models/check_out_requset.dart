import 'package:flower_app/features/checkout/payment_type/payment_types.dart';

class CheckOutRequest {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final PaymentMethodsType paymentMethod;

  const CheckOutRequest({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() => {
        'shippingAddress': {
          'street': street,
          'phone': phone,
          'city': city,
          'lat': lat,
          'long': long,
        },
      };
}
