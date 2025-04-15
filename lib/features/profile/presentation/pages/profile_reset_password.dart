// features/profile/presentation/pages/profile_reset_password.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/utils/validator.dart';
import 'package:flower_app/core/widget/dialog_utils.dart';
import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileResetPassword extends StatefulWidget {
  const ProfileResetPassword({super.key});

  @override
  State<ProfileResetPassword> createState() => _ProfileResetPasswordState();
}

class _ProfileResetPasswordState extends State<ProfileResetPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ///-------------------------------------------TextEditingControllers
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = GetIt.I<ProfileCubit>();
    _newPasswordController.addListener(_updateCubitFormState);
    _confirmPasswordController.addListener(_updateCubitFormState);
    _currentPasswordController.addListener(_updateCubitFormState);

    _updateCubitFormState();
  }

  void _updateCubitFormState() {
    final currentPasswordValid =
        Validator.passwordValidation(_currentPasswordController.text) == null;
    final newPasswordValid =
        Validator.passwordValidation(_newPasswordController.text) == null;
    final confirmPasswordValid = _confirmPasswordController.text.isNotEmpty;
    final passwordsMatch =
        _newPasswordController.text == _confirmPasswordController.text;

    final isValid = currentPasswordValid &&
        newPasswordValid &&
        confirmPasswordValid &&
        passwordsMatch;

    _profileCubit.updateResetPasswordFormValidity(
      currentPassword: _currentPasswordController.text,
      newPassword: _newPasswordController.text,
      confirmPassword: _confirmPasswordController.text,
      isValid: isValid,
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text('profile.reset_password.title'.tr()),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state.resetPasswordState is BaseSuccessState) {
              GetIt.I<DialogUtils>().showSnackBar(
                context: context,
                message: 'profile.reset_password.success_message'.tr(),
                textColor: AppColors.white,
              );
              Navigator.pop(context);
            } else if (state.resetPasswordState is BaseErrorState) {
              final errorState = state.resetPasswordState as BaseErrorState;
              GetIt.I<DialogUtils>().showSnackBar(
                context: context,
                message: errorState.errorMessage,
                textColor: AppColors.white,
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    ///-------------------------------------------Current password
                    TextFormField(
                      controller: _currentPasswordController,
                      obscureText: true,
                      // validator: Validator.passwordValidation,
                      validator: null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText:
                            'profile.reset_password.current_password'.tr(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText:
                            'profile.reset_password.current_password_hint'.tr(),
                      ),
                    ),

                    ///-------------------------------------------New password
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: true,
                      validator: Validator.passwordValidation,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: 'profile.reset_password.new_password'.tr(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText:
                            'profile.reset_password.new_password_hint'.tr(),
                      ),
                    ),

                    ///-------------------------------------------Confirm password
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'profile.reset_password.error.confirm_password_required'
                              .tr();
                        }
                        if (value != _newPasswordController.text) {
                          return 'profile.reset_password.error.passwords_not_match'
                              .tr();
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText:
                            'profile.reset_password.confirm_password'.tr(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText:
                            'profile.reset_password.confirm_password_hint'.tr(),
                      ),
                    ),

                    ///-------------------------------------------Update button
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.isResetPasswordFormValid
                              ? AppColors.primary
                              : AppColors.disableButton,
                        ),
                        onPressed: state.isResetPasswordFormValid
                            ? () {
                                if (formKey.currentState?.validate() ?? false) {
                                  _profileCubit.profileResetPassword(
                                    _currentPasswordController.text,
                                    _newPasswordController.text,
                                  );
                                }
                              }
                            : null,
                        child: state.resetPasswordState is BaseLoadingState
                            ? const Center(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : Text(
                                'profile.reset_password.update_button'.tr(),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
