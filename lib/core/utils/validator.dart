class Validator {
  Validator._();
  static String? phoneNumberValidation(String? number) {
    final RegExp numberRegex = RegExp(
      r"^(\+201|01|00201)[0-2,5]{1}[0-9]{8}$",
    );
    if (number == null || number.trim().isEmpty|| number == "+2") {
      return 'please enter your phone number';
    } else if (numberRegex.hasMatch(number) == false) {
      return 'Egyptian numbers only';
    } else {
      return null;
    }
  }

  static String? passwordValidation(String? password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
    );
    if (password == null || password.trim().isEmpty) {
      return 'Please enter your password';
    } else if (passwordRegex.hasMatch(password) == false) {
      return 'The password is not valid';
    } else {
      return null;
    }
  }

  static String? lastNameValidation(String? name) {
    final RegExp nameRegex = RegExp(
      r"^[a-zA-Z]{2,30}$",
    );
    if (name == null || name.trim().isEmpty) {
      return 'please enter your last name';
    } else if (nameRegex.hasMatch(name) == false) {
      return 'enter valid last name';
    } else {
      return null;
    }
  }

  static String? firstNameValidation(String? name) {
    final RegExp nameRegex = RegExp(
      r"^[a-zA-Z]{2,30}$",
    );
    if (name == null || name.trim().isEmpty) {
      return 'please enter your first name';
    } else if (nameRegex.hasMatch(name) == false) {
      return 'enter valid first name';
    } else {
      return null;
    }
  }

  static String? emailValidate(String? email) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );

    if (email == null || email.trim().isEmpty) {
      return 'please enter your email';
    } else if (emailRegex.hasMatch(email) == false) {
      return 'Please enter a valid email address';
    } else {
      return null;
    }
  }

  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length == 4) {
      return 'Invalid PIN code';
    }

    return null;
  }

  static String? confirmPasswordValidation(String? confirmPassword, String? originalPassword) {
    if (confirmPassword == null || confirmPassword.trim().isEmpty) {
      return 'confirm your password';
    }
    if (confirmPassword != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

}
