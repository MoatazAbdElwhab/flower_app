import 'dart:async';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/routes/navigator_observer.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/core/utils/validator.dart';
import 'package:flower_app/features/checkout/domain/entities/address.dart';
import 'package:flower_app/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/widget/dialog_utils.dart';
import '../../../checkout/domain/entities/checkout_edit_address_arguments.dart';
import '../../data/models/add_adress_model/add_adress_request.dart';
import '../../domain/arguments/edit_address_arguments.dart';
import '../manager/add_address_cubit.dart';
import '../manager/add_address_state.dart';
import '../widgets/map_widget.dart';

class AddOrEditAddressScreen extends StatefulWidget {
  final ProfileEditAddressArgs? profileEditPageArguments;
  final CheckoutEditAddressArgs? checkoutEditAddressArgs;
  const AddOrEditAddressScreen(
      {super.key, this.profileEditPageArguments, this.checkoutEditAddressArgs});

  @override
  State<AddOrEditAddressScreen> createState() => _AddOrEditAddressScreenState();
}

class _AddOrEditAddressScreenState extends State<AddOrEditAddressScreen> {
  late final bool isPushedByEditAddressPage;
  late final bool isEditingAddress;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController recipientNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final Completer<GoogleMapController> mapController = Completer();
  BitmapDescriptor? customMarkerIcon;

  @override
  void didChangeDependencies() {
    final cubit = context.read<AddAddressCubit>();
    isPushedByEditAddressPage = appPreviousRoute == Routes.savedAddresses;
    isEditingAddress = widget.profileEditPageArguments != null ||
        widget.checkoutEditAddressArgs != null;
    if (isEditingAddress) {
      final address = widget.profileEditPageArguments?.editedAddress ??
          widget.checkoutEditAddressArgs!.editedAddress;
      log(address.toString());
      addressController.text = address.city + address.street;
      cityController.text = address.city;
      recipientNameController.text = address.username;
      phoneNumberController.text = address.phone;
      if (address.lat.isNotEmpty && address.long.isNotEmpty) {
        cubit
            .getAreaFromLatAndLng(
                double.parse(address.lat), double.parse(address.long))
            .then((value) {
          areaController.text = value;
        });
      }
    } else {
      cubit.loadAreasAndCities();
      BitmapDescriptor.asset(
        const ImageConfiguration(),
        'assets/icons/mapMarkerIcon.png',
      ).then((icon) {
        customMarkerIcon = icon;
        cubit.getUserPositionFormMap(customMarkerIcon);
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditingAddress
            ? LocaleKeys.addresses_editAddress.tr()
            : LocaleKeys.addAddress_title.tr()),
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
      body: BlocConsumer<AddAddressCubit, AddOrEditAddressState>(
        listenWhen: (prev, curr) {
          final locationChanged =
              prev.getUserLocationOnMap != curr.getUserLocationOnMap;
          final saveStateChanged = prev.addAddressState != curr.addAddressState;
          return locationChanged || saveStateChanged;
        },
        listener: (context, state) {
          if (state.getUserLocationOnMap is BaseSuccessState) {
            addressController.text = state.addressText ?? '';
            cityController.text = state.city ?? '';
            areaController.text = state.area ?? '';
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
            _showDoneDialog(context, isPushedByEditAddressPage);
          } else if (state.addAddressState is BaseErrorState) {
            Navigator.of(context, rootNavigator: true).pop();
            final errorState = state.addAddressState as BaseErrorState;
            GetIt.I<DialogUtils>().showSnackBar(
              context: context,
              message: errorState.errorMessage,
              textColor: AppColors.white,
            );
          } else if (state.getEditedAddressState is BaseErrorState) {
            final address = widget.profileEditPageArguments!.editedAddress;
            addressController.text = address.city + address.street;
            cityController.text = address.city;
            recipientNameController.text = address.username;
            phoneNumberController.text = address.phone;
            getIt<DialogUtils>().showSnackBar(
                textColor: Colors.red,
                message: LocaleKeys.defaultErrorMsg,
                context: context);
          } else if (state.getEditedAddressState is BaseSuccessState) {
            final widgetAddress =
                widget.profileEditPageArguments?.editedAddress ??
                    widget.checkoutEditAddressArgs!.editedAddress;
            if (state.city == null) {
              cityController.text = widgetAddress.city;
            }
            if (state.addressText == null) {
              cityController.text = widgetAddress.city + widgetAddress.street;
            }

            final address = widget.profileEditPageArguments?.editedAddress ??
                widget.checkoutEditAddressArgs!.editedAddress;

            cityController.text = state.city ?? address.city;
            addressController.text =
                state.addressText ?? address.city + address.street;
            areaController.text = state.area ?? '';
            phoneNumberController.text = address.phone;
            recipientNameController.text = address.username;
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
                isEditingAddress == false
                    ? _buildSaveAddressButton(cubit, state)
                    : (widget.profileEditPageArguments != null
                        ? BlocListener<ProfileCubit, ProfileState>(
                            listener: (context, profileState) async {
                              if (profileState.updateAddressState
                                  is BaseSuccessState) {
                                _showDoneDialog(
                                    context, isPushedByEditAddressPage);
                              } else if (profileState.updateAddressState
                                  is BaseErrorState) {
                                getIt<DialogUtils>().showSnackBar(
                                    textColor: Colors.red,
                                    message: (profileState.updateAddressState
                                            as BaseErrorState)
                                        .errorMessage,
                                    context: context);
                              } else if (profileState.updateAddressState
                                  is BaseLoadingState) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => const Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.primary),
                                  ),
                                );
                              }
                            },
                            child: _buildSaveAddressButton(cubit, state),
                          )
                        : BlocListener<CheckoutCubit, CheckoutState>(
                            listener: (context, checkoutState) async {
                              if (checkoutState.addressesState
                                  is BaseSuccessState) {
                                _showDoneDialog(
                                    context, isPushedByEditAddressPage);
                              } else if (checkoutState.addressesState
                                  is BaseErrorState) {
                                getIt<DialogUtils>().showSnackBar(
                                    textColor: Colors.red,
                                    message: (checkoutState.addressesState
                                            as BaseErrorState)
                                        .errorMessage,
                                    context: context);
                              } else if (checkoutState.addressesState
                                  is BaseLoadingState) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => const Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.primary),
                                  ),
                                );
                              }
                            },
                            child: _buildSaveAddressButton(cubit, state),
                          )),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMap(AddOrEditAddressState state) {
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

  Widget _buildAddressForm(AddOrEditAddressState state, AddAddressCubit cubit) {
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

  void _showDoneDialog(BuildContext context, bool isPushedByEditAddressPage) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
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
                composition.duration + const Duration(milliseconds: 200), () {
              if (context.mounted) {
                Navigator.of(context).popUntil((route) =>
                    isPushedByEditAddressPage
                        ? route.settings.name == Routes.savedAddresses
                        : route.settings.name == Routes.checkout);
              }
            });
          },
        ),
      ),
    );
  }

  _buildSaveAddressButton(AddAddressCubit cubit, AddOrEditAddressState state) {
    return ElevatedButton(
      onPressed: () async {
        final addressRequest = AddAndEditAddressRequest(
          street: addressController.text,
          phone: phoneNumberController.text,
          city: cityController.text,
          latValue: state.selectedLocation?.latitude.toString() ??
              widget.profileEditPageArguments?.editedAddress.lat ??
              widget.checkoutEditAddressArgs?.editedAddress.lat ??
              '',
          longValue: state.selectedLocation?.longitude.toString() ??
              widget.profileEditPageArguments?.editedAddress.long ??
              widget.checkoutEditAddressArgs?.editedAddress.long ??
              '',
          username: recipientNameController.text,
        );
        isEditingAddress
            ? (widget.profileEditPageArguments != null
                ? await widget.profileEditPageArguments!.profileCubit
                    .onUpdateAddress(Address(
                        id: widget.profileEditPageArguments!.editedAddress.id,
                        street: addressRequest.street,
                        phone: addressRequest.phone,
                        city: addressRequest.city,
                        lat: addressRequest.latValue,
                        long: addressRequest.longValue,
                        username: addressRequest.username))
                : await widget.checkoutEditAddressArgs!.checkoutCubit
                    .onUpdateAddress(Address(
                        id: widget.profileEditPageArguments?.editedAddress.id ??
                            widget.checkoutEditAddressArgs!.editedAddress.id,
                        street: addressRequest.street,
                        phone: addressRequest.phone,
                        city: addressRequest.city,
                        lat: addressRequest.latValue,
                        long: addressRequest.longValue,
                        username: addressRequest.username)))
            : await cubit.saveUserAddAddress(addressRequest).then((_) async {
                if (widget.checkoutEditAddressArgs != null) {
                  await widget.checkoutEditAddressArgs!.checkoutCubit
                      .getAddresses();
                }
                if (widget.profileEditPageArguments != null) {
                  await widget.profileEditPageArguments!.profileCubit
                      .getUserData();
                }
              });
      },
      child: Text(
        LocaleKeys.addAddress_save_address_button.tr(),
        style: getBoldStyle(color: AppColors.white, fontSize: 16),
      ),
    );
  }
}
