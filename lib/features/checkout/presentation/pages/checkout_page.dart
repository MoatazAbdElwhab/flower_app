import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/checkout/payment_type/payment_types.dart';
import 'package:flower_app/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentation/widgets/delivery_address_section.dart';
import 'package:flower_app/features/checkout/presentation/widgets/delivery_time_section.dart';
import 'package:flower_app/features/checkout/presentation/widgets/gift_section.dart';
import 'package:flower_app/features/checkout/presentation/widgets/payment_method_section.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_colors.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isGift = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _toggleGift(bool value) {
    setState(() {
      isGift = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CheckoutCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.scaffoldBackground,
        ),
        body: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            final cubit = context.read<CheckoutCubit>();
            if (state.addressesState is BaseErrorState) {
              return Center(
                child: Text(
                  (state.addressesState as BaseErrorState).errorMessage,
                  style: getRegularStyle(
                    color: AppColors.grey,
                    fontSize: 16.sp,
                  ),
                ),
              );
            }
            return Skeletonizer(
              enabled: state.addressesState is BaseLoadingState,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DeliveryTimeSection(),
                    _buildSpacer(),
                    const DeliveryAddressSection(),
                    _buildSpacer(),
                    const PaymentMethodSection(),
                    _buildSpacer(),
                    ValueListenableBuilder(
                      valueListenable: cubit.selectedPaymentMethodIndex,
                      builder: (context, value, child) {
                        return AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          alignment: Alignment.topCenter,
                          child: cubit.paymentMethods[value].paymentType ==
                                  PaymentMethodsType.card
                              // ignore: prefer_const_constructors
                              ? GiftSection()
                              : const SizedBox.shrink(),
                        );
                      },
                    ),
                    _buildSpacer(),
                    _buildPlaceOrderButton(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSpacer() {
    return Container(
      height: 24,
      width: double.infinity,
      color: const Color(0xffEAEAEA),
    );
  }

  Widget _buildPlaceOrderButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.checkout_sub_total.tr(),
                style: getRegularStyle(
                  color: AppColors.grey,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                '\$100',
                style: getRegularStyle(
                  color: AppColors.grey,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.checkout_delivery_fee.tr(),
                style: getRegularStyle(
                  color: AppColors.grey,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                '\$10',
                style: getRegularStyle(
                  color: AppColors.grey,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(
            color: AppColors.grey,
            thickness: .5,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.checkout_total.tr(),
                style: getMediumStyle(
                  color: AppColors.black,
                  fontSize: 18.sp,
                ),
              ),
              Text(
                '\$110',
                style: getMediumStyle(
                  color: AppColors.black,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              LocaleKeys.checkout_place_order.tr(),
              style: getMediumStyle(
                color: AppColors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
