import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentation/widgets/delivery_option_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery address',
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
            itemCount: cubit.addresses.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
            itemBuilder: (context, index) {
              return ValueListenableBuilder(
                valueListenable: cubit.selectedAddressIndex,
                builder: (context, value, child) {
                  return DeliveryOptionItem(
                    type: cubit.addresses[index].city,
                    address: cubit.addresses[index].street,
                    isSelected: value == index,
                    onTap: () {
                      cubit.setSelectedAddressIndex(index);
                    },
                    onEdit: () {},
                  );
                },
              );
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 36.h,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.white[70]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, color: AppColors.primary, size: 24),
                  const SizedBox(width: 4),
                  Text(
                    'Add new',
                    style: getMediumStyle(
                      color: AppColors.primary,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
