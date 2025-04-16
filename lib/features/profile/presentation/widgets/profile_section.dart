import 'package:flower_app/core/common_widgets/app_network_image/app_network_image.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/profile/domain/entities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSection extends StatelessWidget {
  final UserData userData;
  final void Function()? onTap;
  const ProfileSection({
    super.key,
    required this.userData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          AppNetworkImage(
            networkImage: userData.photo,
            width: 81,
            height: 81,
            borderRadius: BorderRadius.circular(100),
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            '${userData.firstName} ${userData.lastName}',
            style: getMediumStyle(fontSize: 18.sp, color: AppColors.black),
          ),
          const SizedBox(height: 4),
          Text(
            userData.email,
            style: getMediumStyle(fontSize: 18.sp, color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
