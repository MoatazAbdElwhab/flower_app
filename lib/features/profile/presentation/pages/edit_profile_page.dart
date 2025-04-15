// features/profile/presentation/pages/edit_profile_page.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/nav/presentation/pages/navbar_page.dart';
import 'package:flower_app/features/profile/domain/entities/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/common_widgets/app_network_image/app_network_image.dart';
import '../../../../core/di/injectable.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widget/dialog_utils.dart';
import '../../../../generated/locale_keys.g.dart';
import '../cubit/profile_cubit.dart';

class EditProfilePage extends StatelessWidget {
  final UserData userData;
  const EditProfilePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    bool isDialogShowing = false;

    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..initEditProfileData(userData),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.black,
              size: 24,
            ),
          ),
          title: Text(
            // LocaleKeys.profile_editProfile.tr(),
            'Edit Profile',
            style: getMediumStyle(color: AppColors.black, fontSize: 20),
          ),
          titleSpacing: 0,
          leadingWidth: 35.w,
          actions: const [
            Icon(
              Icons.notifications_none_rounded,
              color: AppColors.black,
              size: 24,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
            if (state.editProfileState is BaseErrorState) {
              getIt<DialogUtils>().showErrorDialog(
                context,
                LocaleKeys.dialogs_error_title.tr(),
                (state.editProfileState as BaseErrorState).errorMessage,
              );
            }
            if (state.editProfileState is BaseSuccessState &&
                !isDialogShowing) {
              isDialogShowing = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            LocaleKeys.profile_updateProfileSuccess.tr(),
                            style: getExtraBoldStyle(
                                color: AppColors.success, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);

                              isDialogShowing = false;
                            },
                            child: Text(LocaleKeys.dialogs_success_ok.tr()),
                          ),
                        ],
                      ),
                    );
                  },
                ).then((_) => isDialogShowing = false);
              });
            }
          }, listenWhen: (previous, current) {
            return previous.editProfileState != current.editProfileState;
          }, buildWhen: (previous, current) {
            return previous.editProfileState != current.editProfileState;
          }, builder: (context, state) {
            final profileCubit = context.read<ProfileCubit>();
            return Form(
              key: profileCubit.editProfileFormKey,
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: AppNetworkImage(
                        networkImage: userData.photo,
                        width: 81,
                        height: 81,
                        borderRadius: BorderRadius.circular(100),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: profileCubit.firstNameController,
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              Validator.firstNameValidation(value),
                          decoration: InputDecoration(
                            labelText: LocaleKeys.firstName_label.tr(),
                          ),
                        ),
                      ),
                      SizedBox(width: 17.w),
                      Expanded(
                        child: TextFormField(
                          controller: profileCubit.lastNameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          validator: (value) =>
                              Validator.firstNameValidation(value),
                          decoration: InputDecoration(
                            labelText: LocaleKeys.lastName_label.tr(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: profileCubit.emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    validator: (value) => Validator.emailValidate(value),
                    decoration: InputDecoration(
                      labelText: LocaleKeys.email_label.tr(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: profileCubit.phoneController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    validator: (value) =>
                        Validator.phoneNumberValidation(value),
                    decoration: InputDecoration(
                      labelText: LocaleKeys.phone_label.tr(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: profileCubit.passwordController,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'password',
                      hintText: "********",
                      suffix: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.profileResetPassword);
                        },
                        child: Text(
                          "Change",
                          style: getBoldStyle(
                                  color: AppColors.primary, fontSize: 12)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Text(
                        "gender.label".tr(),
                        style: getMediumStyle(
                          color: AppColors.grey,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(width: 30.w),
                      _buildGenderOption(
                        value: 'female',
                        label: 'gender.female'.tr(),
                        fillColor: AppColors.primary,
                        isSelected: profileCubit.userGender == 'female',
                      ),
                      SizedBox(width: 16.w),
                      _buildGenderOption(
                        value: 'male',
                        label: 'gender.male'.tr(),
                        fillColor: AppColors.primary,
                        isSelected: profileCubit.userGender == 'male',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 48.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      profileCubit.updateProfileData();
                    },
                    child: state.editProfileState is BaseLoadingState
                        ? const CupertinoActivityIndicator(
                            color: AppColors.white,
                            animating: true,
                            radius: 16,
                          )
                        : Text(
                            LocaleKeys.profile_updateProfile.tr(),
                            style: getMediumStyle(
                                color: AppColors.white, fontSize: 16),
                          ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

Widget _buildGenderOption(
    {required String value,
    required String label,
    required bool isSelected,
    required Color fillColor}) {
  return IgnorePointer(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: isSelected ? value : null,
          fillColor: WidgetStatePropertyAll(fillColor),
          onChanged: (v) {},
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        SizedBox(width: 4.w),
        Text(label),
      ],
    ),
  );
}
