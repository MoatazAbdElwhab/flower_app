import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/routes/routes.dart';

import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widget/dialog_utils.dart';
import 'package:flower_app/features/nav/presentation/pages/navbar_page.dart';
import 'package:flower_app/features/profile/domain/entities/user_data.dart';
import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_app/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:flower_app/features/profile/presentation/widgets/app_bar_section.dart';
import 'package:flower_app/features/profile/presentation/widgets/custom_row_item.dart';
import 'package:flower_app/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:flower_app/features/profile/presentation/widgets/profile_section.dart';
import 'package:flower_app/features/profile/presentation/widgets/settings_section.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserData dummyUserData = UserData(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    gender: 'male',
    phone: '1234567890',
    photo: 'https://via.placeholder.com/150',
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listenWhen: (previous, current) =>
                previous.getUserDataState != current.getUserDataState,
            listener: (context, state) {
              if (state.getUserDataState is BaseErrorState) {
                getIt<DialogUtils>().showErrorDialog(
                  context,
                  LocaleKeys.dialogs_error_title.tr(),
                  (state.getUserDataState as BaseErrorState).errorMessage,
                );
              }
            },
            buildWhen: (previous, current) =>
                previous.getUserDataState != current.getUserDataState,
            builder: (context, state) {
              // Getting ProfileCubit here to send it to LogoutDialog,
              // because Dialog can't see ProfileCubit on its own.
              final cubit = context.read<ProfileCubit>();
              return Skeletonizer(
                enabled: state.getUserDataState is! BaseSuccessState,
                child: Column(
                  children: [
                    const AppBarSection(),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ProfileSection(
                            userData: state.getUserDataState is BaseSuccessState
                                ? (state.getUserDataState as BaseSuccessState)
                                    .data as UserData
                                : dummyUserData,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditProfilePage(
                                    userData: state.getUserDataState
                                            is BaseSuccessState
                                        ? (state.getUserDataState
                                                as BaseSuccessState)
                                            .data as UserData
                                        : dummyUserData,
                                  ),
                                ),
                              ).then((_) {
                                // عند الرجوع، نقوم بتغيير التبويب للـ Profile
                                NavbarPage.of(context)?.changeTab(3);
                                // ثم نقوم بسحب الداتا الجديدة من API
                                context.read<ProfileCubit>().getUserData();
                              });
                            },
                          ),
                          const SizedBox(height: 32),
                          const SettingsSection(),
                          const SizedBox(height: 16),
                          CustomRowItem(
                            leftWidget: const Icon(
                              Icons.logout_outlined,
                              size: 18,
                            ),
                            rightWidget: const Icon(
                              Icons.logout_outlined,
                              color: AppColors.grey,
                              size: 24,
                            ),
                            title: LocaleKeys.profile_logout.tr(),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => LogoutDialog(
                                  cubit: cubit,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
