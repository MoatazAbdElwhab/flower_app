import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/profile/domain/entities/address_widget_location_enum.dart';
import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_app/core/common_widgets/address_widget/address_widget.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/routes/routes.dart';

class SavedAddressPage extends StatelessWidget {
  const SavedAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            LocaleKeys.addresses_savedAddresses.tr(),
          ),
          surfaceTintColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ProfileCubit, ProfileState>(
                listenWhen: (previous, current) =>
                    previous.getUserDataState != current.getUserDataState,
                listener: (context, state) {
                  if (state.getUserDataState is BaseLoadingState) {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()));
                  }
                },
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
                  Navigator.pushNamed(context, Routes.addAndEditAddress);
                },
                child: Text(LocaleKeys.addresses_addNewAddress.tr()))
          ],
        ),
      ),
    );
  }
}
