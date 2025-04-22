import 'package:flower_app/core/common_widgets/app_network_image/app_network_image.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/profile/domain/entities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSection extends StatefulWidget {
  final UserData userData;
  final void Function()? onTap;
  const ProfileSection({
    super.key,
    required this.userData,
    required this.onTap,
  });

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primary.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: widget.onTap,
          child: Column(
            children: [
              widget.userData.photo.isNotEmpty
                  ? AppNetworkImage(
                      networkImage: widget.userData.photo,
                      width: 81,
                      height: 81,
                      borderRadius: BorderRadius.circular(100),
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(
                      height: 81,
                      width: 81,
                    ),
              const SizedBox(height: 16),
              Text(
                '${widget.userData.firstName} ${widget.userData.lastName}',
                style: getMediumStyle(fontSize: 18.sp, color: AppColors.black),
              ),
              const SizedBox(height: 4),
              Text(
                widget.userData.email,
                style: getMediumStyle(fontSize: 18.sp, color: AppColors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
