import 'package:equatable/equatable.dart';
import 'package:flower_app/features/checkout/domain/entities/address.dart';
import 'package:flower_app/features/checkout/payment_type/payment_types.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(const CheckoutState());

  final List<Address> addresses = [
    const Address(
      id: '1',
      street: '123 Main St',
      phone: '1234567890',
      city: 'New York',
      lat: '40.7128',
      long: '-74.0060',
      username: 'John Doe',
    ),
    const Address(
      id: '2',
      street: '456 Main St',
      phone: '1234567890',
      city: 'New York',
      lat: '40.7128',
      long: '-74.0060',
      username: 'John Doe',
    ),
  ];

  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      paymentType: PaymentMethodsType.cash,
      name: 'Cash on delivery',
    ),
    PaymentMethod(
      paymentType: PaymentMethodsType.card,
      name: 'Credit card',
    ),
  ];
  final ValueNotifier<int> selectedAddressIndex = ValueNotifier(0);
  final ValueNotifier<int> selectedPaymentMethodIndex = ValueNotifier(0);
  void setSelectedAddressIndex(int index) {
    selectedAddressIndex.value = index;
  }

  void setSelectedPaymentMethodIndex(int index) {
    selectedPaymentMethodIndex.value = index;
  }
}
