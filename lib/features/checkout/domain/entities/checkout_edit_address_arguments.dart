import 'package:flower_app/features/checkout/presentation/cubit/checkout_cubit.dart';

import 'address.dart';

class CheckoutEditAddressArgs {
  final CheckoutCubit checkoutCubit;
  final Address editedAddress;

  CheckoutEditAddressArgs(
      {required this.checkoutCubit, required this.editedAddress});
}
