import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/resources/app_icon.dart';
import 'package:flower_app/features/add_edit_address/domain/arguments/edit_address_arguments.dart';
import 'package:flower_app/features/checkout/domain/entities/checkout_edit_address_arguments.dart';
import 'package:flower_app/features/profile/domain/entities/address_widget_location_enum.dart';
import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../features/checkout/presentation/cubit/checkout_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';
import '../../../features/checkout/domain/entities/address.dart';

class AddressWidget extends StatelessWidget {
  final Address address;
  final ValueChanged<bool?>? shippingOnChooseAddress;
  final bool? shippingIsSelected;
  final AddressWidgetLocation addressWidgetLocation;
  const AddressWidget(
      {super.key,
      required this.address,
      required this.addressWidgetLocation,
      this.shippingIsSelected,
      this.shippingOnChooseAddress})
      : assert(
            addressWidgetLocation != AddressWidgetLocation.inShippingDetails ||
                (shippingOnChooseAddress != null && shippingIsSelected != null),
            'onChooseAddress must be provided when addressWidgetLocation is shipping details');
  @override
  Widget build(BuildContext context) {
    const widgetElementSpacing = 8.0;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: widgetElementSpacing),
      padding: const EdgeInsets.all(widgetElementSpacing),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.25),
            blurRadius: 4,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: 24,
                        height: 24,
                        child: addressWidgetLocation ==
                                AddressWidgetLocation.inShippingDetails
                            ? Radio(
                                value: true,
                                groupValue: shippingIsSelected,
                                onChanged: shippingOnChooseAddress!,
                                activeColor: AppColors.primary,
                                fillColor:
                                    WidgetStateProperty.all(AppColors.primary),
                                visualDensity: VisualDensity.compact,
                              )
                            : const Icon(Icons.location_on_outlined)),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        address.city,
                        overflow: TextOverflow.ellipsis,
                        style: getMediumStyle(
                          color: AppColors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    if (addressWidgetLocation ==
                        AddressWidgetLocation.inSavedAddresses)
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: BlocBuilder<ProfileCubit, ProfileState>(
                              buildWhen: (previous, current) =>
                                  previous.deleteAddressState !=
                                  current.deleteAddressState,
                              builder: (context, state) =>
                                  state.deleteAddressState
                                              is BaseLoadingState &&
                                          state.activeAddressid == address.id
                                      ? const SizedBox(
                                          height: 8,
                                          width: 20,
                                          child: LinearProgressIndicator())
                                      : InkWell(
                                          onTap: () {
                                            context
                                                .read<ProfileCubit>()
                                                .onDeleteAddress(address.id);
                                          },
                                          child: SvgPicture.asset(
                                            AppIcon.delete,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.addAndEditAddress,
                                    arguments: ProfileEditAddressArgs(
                                        profileCubit:
                                            context.read<ProfileCubit>(),
                                        editedAddress: address));
                              },
                              child: SvgPicture.asset(
                                AppIcon.edit,
                                fit: BoxFit.cover,
                              )),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: widgetElementSpacing),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 26),
                  child: Text(
                    address.street,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getRegularStyle(
                      color: AppColors.grey,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (addressWidgetLocation == AddressWidgetLocation.inShippingDetails)
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.addAndEditAddress,
                    arguments: CheckoutEditAddressArgs(
                        checkoutCubit: context.read<CheckoutCubit>(),
                        editedAddress: address));
              },
              child: SizedBox(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(
                    AppIcon.edit,
                  )),
            )
        ],
      ),
    );
  }
}
//
// IconButton(
// icon: const Icon(Icons.edit_outlined, color: Colors.grey),
// onPressed: () {
//
// },
// ),
