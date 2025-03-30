// test/helpers/test_helpers.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'mock_translation_service.dart';

///creating this file to handle localization and screen util initialization in widget tests
///this will help to avoid repeating the same code in every widget test file
///this file will be used in widget tests to initialize localization and screen util


Widget testableWidget({
  required Widget child,
  AuthCubit? authCubit,
}) {
  return EasyLocalization(
    supportedLocales: const [Locale('en', 'US')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en', 'US'),
    assetLoader: const MockTranslationLoader(),
    child: Builder(
      builder: (context) {
        if (authCubit != null) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit,
            child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: child,
            ),
          );
        }
        
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: child,
        );
      },
    ),
  );
}

/// For backward compatibility with existing tests
Future<Widget> createTestableWidget(Widget child) async {
  await EasyLocalization.ensureInitialized();
  
  return EasyLocalization(
    supportedLocales: const [Locale('en', 'US')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en', 'US'),
    assetLoader: const MockTranslationLoader(),
    child: Builder(
      builder: (context) => ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            ...context.localizationDelegates,
          ],
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: child,
        ),
      ),
    ),
  );
}

/// Setup for widget tests
Future<void> testSetup() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
}

/// Extension for widget testing
extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) async {
    await pumpWidget(await createTestableWidget(widget));
  }
}
