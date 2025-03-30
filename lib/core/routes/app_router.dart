// core/routes/app_router.dart

import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/features/auth/presentation/pages/login_page.dart';
import 'package:flower_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.login:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const LoginPage(),
      );
    case Routes.signup:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) =>  const SignupPage(),
    );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
