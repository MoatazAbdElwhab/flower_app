import 'package:easy_localization/easy_localization.dart';

class Validator {
  Validator._();

  static String? phoneNumberValidation(String? number) {
    final RegExp numberRegex = RegExp(
      r"^(\+201|01|00201)[0-2,5]{1}[0-9]{8}$",
    );
    if (number == null || number.trim().isEmpty || number == "+2") {
      return 'phone.error.empty'.tr();
    } else if (numberRegex.hasMatch(number) == false) {
      return 'phone.error.invalid'.tr();
    } else {
      return null;
    }
  }

  static String? passwordValidation(String? password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.?[A-Z])(?=.?[a-z])(?=.*?[0-9]).{6,}$',
    );
    if (password == null || password.trim().isEmpty) {
      return 'password.error.empty'.tr();
    } else if (passwordRegex.hasMatch(password) == false) {
      return 'password.error.invalid'.tr();
    } else {
      return null;
    }
  }

  static String? lastNameValidation(String? name) {
    final RegExp nameRegex = RegExp(
      r"^[a-zA-Z]{2,30}$",
    );
    if (name == null || name.trim().isEmpty) {
      return 'lastName.error.empty'.tr();
    } else if (nameRegex.hasMatch(name) == false) {
      return 'lastName.error.invalid'.tr();
    } else {
      return null;
    }
  }

  static String? firstNameValidation(String? name) {
    final RegExp nameRegex = RegExp(
      r"^[a-zA-Z]{2,30}$",
    );
    if (name == null || name.trim().isEmpty) {
      return 'firstName.error.empty'.tr();
    } else if (nameRegex.hasMatch(name) == false) {
      return 'firstName.error.invalid'.tr();
    } else {
      return null;
    }
  }

  static String? emailValidate(String? email) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );

    if (email == null || email.trim().isEmpty) {
      return 'email.error.empty'.tr();
    } else if (emailRegex.hasMatch(email) == false) {
      return 'email.error.invalid'.tr();
    } else {
      return null;
    }
  }

  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length == 4) {
      return 'otp.invalid'.tr();
    }

    return null;
  }

  static String? confirmPasswordValidation(
      String? confirmPassword, String? originalPassword) {
    if (confirmPassword == null || confirmPassword.trim().isEmpty) {
      return 'confirmPassword.error.empty'.tr();
    }
    if (confirmPassword != originalPassword) {
      return 'confirmPassword.error.mismatch'.tr();
    }
    return null;
  }
}
