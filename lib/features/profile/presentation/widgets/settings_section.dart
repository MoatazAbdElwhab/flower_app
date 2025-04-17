// features/profile/presentation/widgets/settings_section.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/resources/app_icon.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_app/features/profile/presentation/widgets/custom_row_item.dart';
import 'package:flower_app/features/profile/presentation/widgets/language_bottom_sheet.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return Column(
      children: [
        CustomRowItem(
          leftWidget: SvgPicture.asset(
            AppIcon.myOrders,
            width: 20,
            height: 20,
          ),
          title: LocaleKeys.profile_myOrders.tr(),
          onTap: () {},
        ),
        CustomRowItem(
          leftWidget: SvgPicture.asset(
            AppIcon.location,
            width: 20,
            height: 20,
          ),
          title: LocaleKeys.profile_savedAddress.tr(),
          onTap: () {},
        ),
        const SizedBox(height: 16),
        Divider(
          color: AppColors.white[70],
          height: 0,
          thickness: .5,
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: cubit.isNotificationEnabled,
          builder: (context, value, child) {
            return CustomRowItem(
              leftWidget: SizedBox(
                width: 42,
                height: 20,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Switch.adaptive(
                    value: cubit.isNotificationEnabled.value,
                    onChanged: (value) {
                      cubit.changeNotification();
                    },
                    activeColor: AppColors.white,
                    activeTrackColor: AppColors.primary,
                  ),
                ),
              ),
              title: LocaleKeys.profile_notification.tr(),
              onTap: cubit.changeNotification,
            );
          },
        ),
        const SizedBox(height: 16),
        Divider(
          color: AppColors.white[70],
          height: 0,
          thickness: .5,
        ),
        const SizedBox(height: 16),
        CustomRowItem(
          leftWidget: const Icon(
            Icons.translate_outlined,
            size: 18,
          ),
          rightWidget: Text(
            LocaleKeys.profile_userLanguage.tr(),
            style: getRegularStyle(
              fontSize: 11.sp,
              color: AppColors.primary,
            ),
          ),
          title: LocaleKeys.profile_language.tr(),
          onTap: () {
            showModalBottomSheet(
              context: context,
              enableDrag: true,
              showDragHandle: true,
              backgroundColor: AppColors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              builder: (context) => const LanguageBottomSheet(),
            );
          },
        ),
        CustomRowItem(
          title: LocaleKeys.profile_aboutUs.tr(),
          onTap: () {},
        ),
        CustomRowItem(
          title: LocaleKeys.profile_termsAndConditions.tr(),
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.termsAndConditions,
            );
          },
        ),
        const SizedBox(height: 16),
        Divider(
          color: AppColors.white[70],
          height: 0,
          thickness: .5,
        ),
      ],
    );
  }
}
