import 'dart:developer';

import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_app/features/profile/presentation/pages/saved_address_page/widgets/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';

class SavedAddressPage extends StatelessWidget {
  const SavedAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Address'),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          // buildWhen: (previous, current) {
          //   log('1');
          //   log((current.userData?.addresses?.length).toString());
          //   return true;
          // },
          builder: (context, state) => state.userData == null ||
                  state.userData!.addresses == null ||
                  state.userData!.addresses!.isEmpty
              ? const Center(
                  child: Text('no address available'),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.userData!.addresses!.length,
                        itemBuilder: (context, index) {
                          return AddressWidget(
                            onTap: () {

                            },
                            address: state.userData!.addresses![index],
                          );
                        },
                      ),
                    ),
                    ElevatedButton(onPressed: () {

                    }, child: Text('add new address'))
                  ],
                ),
        ),
      ),
    );
  }
}
