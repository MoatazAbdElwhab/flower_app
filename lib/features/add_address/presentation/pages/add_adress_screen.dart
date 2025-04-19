import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/core/utils/validator.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/widget/dialog_utils.dart';
import '../manager/add_address_cubit.dart';
import '../manager/add_address_state.dart';
import '../widgets/map_widget.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final Completer<GoogleMapController> mapController = Completer();
  BitmapDescriptor? customMarkerIcon;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AddAddressCubit>();
    cubit.loadAreasAndCities();
    BitmapDescriptor.asset(
      const ImageConfiguration(),
      'assets/icons/mapMarkerIcon.png',
    ).then((icon) {
      customMarkerIcon = icon;
      cubit.getUserPositionFormMap(customMarkerIcon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.addAddress_title.tr()),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.black,
            size: 24,
          ),
        ),
        titleSpacing: 0,
        leadingWidth: 35.w,
      ),
      body: BlocConsumer<AddAddressCubit, AddAddressState>(
        listenWhen: (prev, curr) {
          final locationChanged =
              prev.getUserLocationOnMap != curr.getUserLocationOnMap;
          final saveStateChanged = prev.addAddressState != curr.addAddressState;
          return locationChanged || saveStateChanged;
        },
        listener: (context, state) {
          final cubit = context.read<AddAddressCubit>();

          if (state.getUserLocationOnMap is BaseSuccessState) {
            cubit.addressController.text = state.address ?? '';
            cubit.cityController.text = state.city ?? '';
            cubit.areaController.text = state.area ?? '';
          }

          if (state.addAddressState is BaseLoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          } else if (state.addAddressState is BaseSuccessState) {
            Navigator.of(context, rootNavigator: true).pop(); // Close loading
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: AppColors.white.withAlpha(204),
                content: Lottie.asset(
                  'assets/icons/sucess_animation.json',
                  repeat: false,
                  height: 150.h,
                  width: 150.w,
                  fit: BoxFit.contain,
                  onLoaded: (composition) {
                    Future.delayed(
                        composition.duration +
                            const Duration(milliseconds: 200), () {
                      if (context.mounted) {
                        Navigator.of(context, rootNavigator: true)
                            .pop(); // Close success dialog
                        Navigator.of(context).pop();
                      }
                    });
                  },
                ),
              ),
            );
          } else if (state.addAddressState is BaseErrorState) {
            Navigator.of(context, rootNavigator: true).pop();
            final errorState = state.addAddressState as BaseErrorState;
            GetIt.I<DialogUtils>().showSnackBar(
              context: context,
              message: errorState.errorMessage,
              textColor: AppColors.white,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AddAddressCubit>();
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                _buildMap(state),
                SizedBox(height: 24.h),
                _buildAddressForm(state, cubit),
                SizedBox(height: 48.h),
                ElevatedButton(
                  onPressed: () {
                    cubit.saveUserAddress();
                  },
                  child: Text(
                    LocaleKeys.addAddress_save_address_button.tr(),
                    style: getBoldStyle(color: AppColors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMap(AddAddressState state) {
    return Container(
      height: 145.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: state.getUserLocationOnMap is BaseLoadingState
          ? _buildMapShimmer()
          : state.getUserLocationOnMap is BaseErrorState
              ? Center(
                  child: Text(
                    LocaleKeys.addAddress_map_error_message.tr(),
                    textAlign: TextAlign.center,
                    style: getBoldStyle(color: AppColors.black, fontSize: 18),
                  ),
                )
              : Stack(
                  children: [
                    MapWidget(
                      selectedLocation: state.selectedLocation,
                      markers: state.markers,
                      onMapCreated: (controller) {
                        if (!mapController.isCompleted) {
                          mapController.complete(controller);
                        }
                      },
                      onTap: (latLng) {
                        context
                            .read<AddAddressCubit>()
                            .updateLocationAndAddress(
                              latLng,
                              customMarkerIcon,
                            );
                      },
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: IconButton(
                          icon: const Icon(Icons.my_location,
                              color: AppColors.white),
                          onPressed: () {
                            context
                                .read<AddAddressCubit>()
                                .centerToUserLocation(
                                  customMarkerIcon,
                                );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildAddressForm(AddAddressState state, AddAddressCubit cubit) {
    return Form(
      key: cubit.saveAdressFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: cubit.addressController,
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
            controller: cubit.phoneNumberController,
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
            controller: cubit.recipientNameController,
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
                  controller: cubit.cityController,
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
                    cubit.cityChanged(val);
                  },
                ),
              ),
              SizedBox(width: 17.w),
              Expanded(
                child: TextFormField(
                  controller: cubit.areaController,
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

  Widget _buildMapShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 145.h,
        width: double.infinity,
        color: Colors.grey[300],
      ),
    );
  }
}
