// core/routes/app_router.dart

import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/features/auth/presentation/pages/login_page.dart';
import 'package:flower_app/features/home/presentation/pages/home_screen.dart';
import 'package:flower_app/features/nav/nav_bar.dart';
import 'package:flower_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flower_app/features/nav/presentation/pages/navbar_page.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/signup_page.dart';

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
    case Routes.navbar :
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const NavbarPage(),
      );
    case Routes.home:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomePage(),
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
