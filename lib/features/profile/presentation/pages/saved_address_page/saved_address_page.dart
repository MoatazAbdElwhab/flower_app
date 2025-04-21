import 'dart:developer';

import 'package:flower_app/features/checkout/payment_type/payment_types.dart';
import 'package:flower_app/features/profile/domain/entities/address_widget_location_enum.dart';
import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_app/core/common_widgets/address_widget/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';

class SavedAddressPage extends StatelessWidget {
  const SavedAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Saved Address'),
          surfaceTintColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                // buildWhen: (previous, current) {
                //   log('1');
                //   log((current.userData?.addresses?.length).toString());
                //   return true;
                // },
                builder: (context, state) => state.userData == null ||
                        state.userData!.addresses == null ||
                        state.userData!.addresses!.isEmpty
                    ? const Column(
                        children: [
                          Center(
                            child: Text('No address available'),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.userData!.addresses!.length,
                                  itemBuilder: (context, index) =>
                                      AddressWidget(
                                        address:
                                            state.userData!.addresses![index],
                                        addressWidgetLocation:
                                            AddressWidgetLocation
                                                .inSavedAddresses,
                                      )),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.addAddress).then((_) {
                    if (context.mounted) {
                      context.read<ProfileCubit>().getUserData();
                    }
                  });
                },
                child: const Text('Add new address'))
          ],
        ),
      ),
    );
  }
}
