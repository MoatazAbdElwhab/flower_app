import 'package:flower_app/core/routes/routes.dart';

import 'package:flower_app/features/auth/presentation/pages/pin_code_page.dart';
import 'package:flower_app/features/auth/presentation/pages/forget_password_page.dart';
import 'package:flower_app/features/auth/presentation/pages/login_page.dart';
import 'package:flower_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flower_app/features/home/presentation/pages/home_screen.dart';
import 'package:flower_app/features/nav/nav_bar.dart';
import 'package:flower_app/features/splash/splash_screen.dart';

import 'package:flower_app/features/auth/presentation/pages/reset_password_page.dart';

import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const SplashScreen(),
      );
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

    case Routes.home:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomeScreen(),
      );

    case Routes.navbar:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const NavbarPage(),
      );
    case Routes.forgetPassword:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ForgetPasswordPage(),
      );

    case Routes.pinCode:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PinCodePage(),
      );

    case Routes.resetPassword:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ResetPasswordPage(),
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
