import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widget/dialog_utils.dart';
import 'package:flower_app/features/checkout/data/models/check_out_requset.dart';
import 'package:flower_app/features/checkout/domain/entities/address.dart';
import 'package:flower_app/features/checkout/domain/entities/check_out_session_detailes.dart';
import 'package:flower_app/features/checkout/domain/usecases/create_checkout_session_use_case.dart';
import 'package:flower_app/features/checkout/domain/usecases/get_adresses_use_case.dart';
import 'package:flower_app/features/checkout/payment_type/payment_types.dart';
import 'package:flower_app/features/profile/domain/usecases/update_address_usecase.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final GetAddressesUseCase getAddressesUseCase;
  final UpdateAddressUsecase updateAddressUsecase;
  final CreateCheckoutSessionUseCase createCheckoutSessionUseCase;
  final DialogUtils dialogUtils;
  CheckoutCubit(
    this.getAddressesUseCase,
    this.updateAddressUsecase,
    this.createCheckoutSessionUseCase,
    this.dialogUtils,
  ) : super(const CheckoutState()) {
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
  final ValueNotifier<bool> checkoutState = ValueNotifier(false);

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

  Future<void> onUpdateAddress(Address address) async {
    emit(state.copyWith(addressesState: BaseLoadingState()));
    try {
      final newAddresses = await updateAddressUsecase(address);
      emit(state.copyWith(
          addressesState: BaseSuccessState(), addresses: newAddresses));
      await getAddresses();
    } catch (e) {
      emit(state.copyWith(addressesState: BaseErrorState(e.toString())));
    }
  }

  Future<void> createCheckoutSession(BuildContext context) async {
    if (state.addresses == null || state.addresses?.isEmpty == true) return;
    checkoutState.value = true;
    final address = state.addresses![selectedAddressIndex.value];
    final result = await createCheckoutSessionUseCase(
      CheckOutRequest(
        paymentMethod:
            paymentMethods[selectedPaymentMethodIndex.value].paymentType,
        city: address.city,
        street: address.street,
        lat: address.lat,
        long: address.long,
        phone:
            phoneController.text.isEmpty ? address.phone : phoneController.text,
      ),
    );
    result.fold(
      (error) {
        dialogUtils.showSnackBar(
          context: context,
          message: error.message,
          textColor: AppColors.error,
        );
        checkoutState.value = false;
      },
      (response) {
        checkoutState.value = false;
        _navigateToPaymentPage(context, response);
      },
    );
  }

  Future<void> _navigateToPaymentPage(
    BuildContext context,
    CheckOutSessionDetails response,
  ) async {
    switch (response) {
      case OnlinePaymentDetails():
        Navigator.pushNamed(context, Routes.webViewPage, arguments: response)
            .then((value) {
          if (!context.mounted) return;
          if (value == true) {
            dialogUtils.showSnackBar(
              context: context,
              message: LocaleKeys.payment_success.tr(),
              textColor: AppColors.success,
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.navbar,
              (route) => false,
            );
          } else {
            dialogUtils.showErrorDialog(
              context,
              LocaleKeys.payment_error.tr(),
              LocaleKeys.payment_error.tr(),
            );
          }
        });
      case CashPaymentDetails():
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.navbar,
          (route) => false,
        );
    }
  }
}
