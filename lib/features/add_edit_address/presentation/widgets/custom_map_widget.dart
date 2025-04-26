import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/add_edit_address/presentation/manager/add_address_cubit.dart';
import 'package:flower_app/features/add_edit_address/presentation/manager/add_address_state.dart';
import 'package:flower_app/features/add_edit_address/presentation/widgets/map_widget.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';

class CustomMapWidget extends StatelessWidget {
  final AddOrEditAddressState state;
 final Completer<GoogleMapController> mapController;
 final BitmapDescriptor? customMarkerIcon;
  const CustomMapWidget({super.key, required this.state, required this.mapController, required this.customMarkerIcon});

  @override
  Widget build(BuildContext context) {
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
                        onTap: (latLng) async {
                          context
                              .read<AddAddressCubit>()
                              .updateLocationAndAddress(
                                latLng,
                                customMarkerIcon,
                              );

                          if (mapController.isCompleted) {
                            final controller = await mapController.future;
                            await controller.animateCamera(
                              CameraUpdate.newLatLng(latLng),
                            );
                          }
                        }),
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