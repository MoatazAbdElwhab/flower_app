import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/utils/validator.dart';
import 'package:flower_app/features/add_edit_address/presentation/manager/add_address_cubit.dart';
import 'package:flower_app/features/add_edit_address/presentation/manager/add_address_state.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEditAdressForm extends StatelessWidget {
  final AddAddressCubit cubit;
  final TextEditingController addressController;
  final TextEditingController recipientNameController;
  final TextEditingController phoneNumberController;
  final TextEditingController areaController;
  final TextEditingController cityController;
  final AddOrEditAddressState state;

  const AddEditAdressForm(
      {super.key,
      required this.cubit,
      required this.addressController,
      required this.recipientNameController,
      required this.phoneNumberController,
      required this.areaController,
      required this.cityController,
      required this.state});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.saveAdressFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: addressController,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => Validator.addressValidation(value),
            decoration: InputDecoration(
              labelText: LocaleKeys.addAddress_address_label.tr(),
              hintText: LocaleKeys.addAddress_address_hint.tr(),
            ),
          ),
          SizedBox(height: 17.h),
          TextFormField(
            controller: phoneNumberController,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            keyboardType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => Validator.phoneNumberValidation(value),
            decoration: InputDecoration(
              labelText: LocaleKeys.addAddress_phone_label.tr(),
              hintText: LocaleKeys.addAddress_phone_hint.tr(),
            ),
          ),
          SizedBox(height: 17.h),
          TextFormField(
            controller: recipientNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            validator: (value) => Validator.recipientNameValidation(value),
            decoration: InputDecoration(
              labelText: LocaleKeys.addAddress_recipient_name_label.tr(),
              hintText: LocaleKeys.addAddress_recipient_name_hint.tr(),
            ),
          ),
          SizedBox(height: 17.h),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: cityController,
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => Validator.cityValidation(value),
                  decoration: InputDecoration(
                    labelText: LocaleKeys.addAddress_city_label.tr(),
                    hintText: LocaleKeys.addAddress_city_hint.tr(),
                    suffixIcon: PopupMenuButton<String>(
                      color: AppColors.white,
                      constraints: BoxConstraints(
                        maxHeight: 250.h,
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      onSelected: (val) {
                        cityController.text = val;
                        cubit.cityChanged(val);
                      },
                      itemBuilder: (_) => state.localCities
                          .map((city) => PopupMenuItem(
                                value: city,
                                child: Text(city),
                              ))
                          .toList(),
                    ),
                  ),
                  onChanged: (val) {
                    cityController.text = val;
                    cubit.cityChanged(val);
                  },
                ),
              ),
              SizedBox(width: 17.w),
              Expanded(
                child: TextFormField(
                  controller: areaController,
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => Validator.areaValidation(value),
                  decoration: InputDecoration(
                    labelText: LocaleKeys.addAddress_area_label.tr(),
                    hintText: LocaleKeys.addAddress_area_hint.tr(),
                    suffixIcon: PopupMenuButton<String>(
                      color: AppColors.white,
                      constraints: BoxConstraints(
                        maxHeight: 250.h,
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      onSelected: (val) {
                        areaController.text = val;
                        cubit.areaChanged(val);
                      },
                      itemBuilder: (_) => state.localAreas
                          .map((area) => PopupMenuItem(
                                value: area,
                                child: Text(area),
                              ))
                          .toList(),
                    ),
                  ),
                  onChanged: (val) {
                    areaController.text = val;
                    cubit.areaChanged(val);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
