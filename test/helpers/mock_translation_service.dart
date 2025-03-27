// test/helpers/mock_translation_service.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


///----------i create this mock translation file to simplify using and testing the translation service
class MockTranslationService extends StatelessWidget {
  final Widget child;

  const MockTranslationService({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale('en', 'US')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      assetLoader: const MockTranslationLoader(),
      child: Builder(
        builder: (context) {
          return child;
        },
      ),
    );
  }
}

class MockTranslationLoader extends AssetLoader {
  const MockTranslationLoader();

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {

    return {
      "auth": {
        "login": {
          "title": "Login",
          "email": "Email",
          "password": "Password",
          "submit": "Login",
          "guest": "Sign in as guest",
          "remember_me": "Remember me"
        },
        "errors": {
          "invalid_credentials": "Invalid credentials",
          "invalid_email": "Invalid email",
          "required_field": "This field is required"
        }
      }
    };
  }
}

// Override tr() extension method
extension MockTranslationExtension on String {
  String tr() {
    return this;
  }
}
