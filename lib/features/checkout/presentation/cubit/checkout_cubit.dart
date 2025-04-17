import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/checkout/domain/entities/address.dart';
import 'package:flower_app/features/checkout/domain/usecases/get_adresses_use_case.dart';
import 'package:flower_app/features/checkout/payment_type/payment_types.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final GetAddressesUseCase getAddressesUseCase;
  CheckoutCubit(this.getAddressesUseCase) : super(const CheckoutState()) {
    getAddresses();
  }

  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      paymentType: PaymentMethodsType.cash,
      name: LocaleKeys.checkout_payment_method_cash.tr(),
    ),
    PaymentMethod(
      paymentType: PaymentMethodsType.card,
      name: LocaleKeys.checkout_payment_method_card.tr(),
    ),
  ];
  final ValueNotifier<int> selectedAddressIndex = ValueNotifier(0);
  final ValueNotifier<int> selectedPaymentMethodIndex = ValueNotifier(0);
  final ValueNotifier<bool> isGift = ValueNotifier(false);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void setSelectedAddressIndex(int index) {
    selectedAddressIndex.value = index;
  }

  void setSelectedPaymentMethodIndex(int index) {
    selectedPaymentMethodIndex.value = index;
  }

  void toggleGift() {
    isGift.value = !isGift.value;
  }

  Future<void> getAddresses() async {
    emit(state.copyWith(addressesState: BaseLoadingState()));
    final result = await getAddressesUseCase();
    result.fold(
      (error) =>
          emit(state.copyWith(addressesState: BaseErrorState(error.message))),
      (addresses) => emit(
        state.copyWith(
          addresses: addresses,
          addressesState: BaseSuccessState(data: addresses),
        ),
      ),
    );
  }
}
