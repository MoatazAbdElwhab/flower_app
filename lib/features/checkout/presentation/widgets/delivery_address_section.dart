import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/common_widgets/address_widget/address_widget.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_app/features/profile/domain/entities/address_widget_location_enum.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/routes.dart';

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
            LocaleKeys.checkout_delivery_address.tr(),
            style: getMediumStyle(
              color: AppColors.black,
              fontSize: 18.sp,
            ),
          ),
          const SizedBox(height: 16),
          if (cubit.state.addresses != null &&
              cubit.state.addresses!.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: cubit.state.addresses?.length ?? 0,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
              itemBuilder: (context, index) {
                return ValueListenableBuilder(
                  valueListenable: cubit.selectedAddressIndex,
                  builder: (context, value, child) {
                    return AddressWidget(
                      address: cubit.state.addresses![index],
                      addressWidgetLocation:
                          AddressWidgetLocation.inShippingDetails,
                      shippingOnChooseAddress: (_) =>
                          cubit.setSelectedAddressIndex(index),
                      shippingIsSelected: value == index,
                    );
                    // return DeliveryOptionItem(
                    //   type: cubit.state.addresses![index].city,
                    //   address: cubit.state.addresses![index].street,
                    //   isSelected: value == index,
                    //   onTap: () {
                    //     cubit.setSelectedAddressIndex(index);
                    //   },
                    //   onEdit: () {},
                    // );
                  },
                );
              },
            ),
          const SizedBox(height: 16),
          SizedBox(
            height: 36.h,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.addAndEditAddress);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.white[70]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, color: AppColors.primary, size: 24),
                  const SizedBox(width: 4),
                  Text(
                    LocaleKeys.checkout_add_new.tr(),
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
