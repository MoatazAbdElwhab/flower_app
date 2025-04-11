// features/profile/presentation/pages/profile_reset_password.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/utils/validator.dart';
import 'package:flutter/material.dart';

class ProfileResetPassword extends StatefulWidget {
  const ProfileResetPassword({super.key});

  @override
  State<ProfileResetPassword> createState() => _ProfileResetPasswordState();
}

class _ProfileResetPasswordState extends State<ProfileResetPassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile.reset_password.title'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              ///-------------------------------------------password
              TextFormField(
                obscureText: true,
                validator: Validator.passwordValidation,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'profile.reset_password.current_password'.tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'profile.reset_password.current_password_hint'.tr(),
                ),
              ),

              ///-------------------------------------------new password
              const SizedBox(height: 24),
              TextFormField(
                obscureText: true,
                validator: Validator.passwordValidation,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'profile.reset_password.new_password'.tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'profile.reset_password.new_password_hint'.tr(),
                ),
              ),

              ///-------------------------------------------Confirm password
              const SizedBox(height: 24),
              TextFormField(
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'profile.reset_password.confirm_password'.tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'profile.reset_password.confirm_password_hint'.tr(),
                ),
              ),

              //update
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {}
                },
                child: Text('profile.reset_password.update_button'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
