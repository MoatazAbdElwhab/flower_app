import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';

import '../../../checkout/domain/entities/address.dart';

class ProfileEditAddressArgs {
  final ProfileCubit profileCubit;
  final Address editedAddress;

  ProfileEditAddressArgs({required this.profileCubit, required this.editedAddress});
}
