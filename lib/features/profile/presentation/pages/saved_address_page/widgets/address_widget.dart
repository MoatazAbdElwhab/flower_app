import 'dart:developer';

import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/resources/app_icon.dart';
import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_styles.dart';
import '../../../../../checkout/domain/entities/address.dart';

class AddressWidget extends StatelessWidget {
  final Address address;
  const AddressWidget({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return Container(
      height: 86,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const SizedBox(
                  width: 24, child: Icon(Icons.location_on_outlined)),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  buildWhen: (previous, current) =>
                      previous.deleteAddressState != current.deleteAddressState,
                  builder: (context, state) =>
                      state.deleteAddressState is BaseLoadingState
                          ? const SizedBox(
                              height: 8,
                              width: 20,
                              child: LinearProgressIndicator())
                          : InkWell(
                              onTap: () {
                                cubit.onDeleteAddress(address.id);
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
                    cubit.onUpdateAddress(address);
                  },
                  child: SvgPicture.asset(
                    AppIcon.edit,
                    fit: BoxFit.cover,
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 24),
            child: Text(
              address.street,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: getRegularStyle(
                color: AppColors.grey,
                fontSize: 14.sp,
              ),
            ),
          ),
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
