import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/checkout/presentation/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  int selectedPaymentMethod = 0;

  @override
  Widget build(BuildContext context) {
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
          PaymentMethodItem(
            title: 'Cash on delivery',
            isSelected: selectedPaymentMethod == 0,
            onTap: () {
              setState(() {
                selectedPaymentMethod = 0;
              });
            },
          ),
          PaymentMethodItem(
            title: 'Credit card',
            isSelected: selectedPaymentMethod == 1,
            onTap: () {
              setState(() {
                selectedPaymentMethod = 1;
              });
            },
          ),
        ],
      ),
    );
  }
}
