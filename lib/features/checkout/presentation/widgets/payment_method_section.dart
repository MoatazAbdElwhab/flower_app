import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentation/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment method',
            style: getMediumStyle(
              color: AppColors.black,
              fontSize: 18.sp,
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: cubit.paymentMethods.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemBuilder: (context, index) {
              return ValueListenableBuilder(
                valueListenable: cubit.selectedPaymentMethodIndex,
                builder: (context, value, child) {
                  return PaymentMethodItem(
                    title: cubit.paymentMethods[index].name,
                    isSelected: value == index,
                    onTap: () {
                      cubit.setSelectedPaymentMethodIndex(index);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
