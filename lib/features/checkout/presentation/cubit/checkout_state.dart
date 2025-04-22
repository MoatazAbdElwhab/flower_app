part of 'checkout_cubit.dart';

class CheckoutState extends Equatable {
  const CheckoutState({
    this.addresses,
    this.addressesState,
  });

  final List<Address>? addresses;
  final BaseState? addressesState;

  CheckoutState copyWith({
    List<Address>? addresses,
    BaseState? addressesState,
    ValueNotifier<bool>? checkoutState,
  }) {
    return CheckoutState(
      addresses: addresses ?? this.addresses,
      addressesState: addressesState ?? this.addressesState,
    );
  }

  @override
  List<Object?> get props => [
        addresses,
        addressesState,
      ];
}
