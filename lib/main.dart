import 'dart:isolate';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flower_app/core/app_bloc_observer.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/routes/app_router.dart';
import 'package:flower_app/core/routes/navigator_observer.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flower_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flower_app/features/nav/presentation/cubit/nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/theme_data/theme_data_light.dart';
import 'firebase_options.dart';

// global variable
bool? isUserLoggedInAutomatically;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await _configureFirebase();
  await configureDependencies().then(
    (_) async {
      isUserLoggedInAutomatically = await getIt<AuthCubit>().isUserLoggedIn();
    },
  );
  Bloc.observer = AppBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AE')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (BuildContext context) => getIt<AuthCubit>(),
          ),
          BlocProvider<CartBloc>(
            create: (BuildContext context) => getIt<CartBloc>(),
          ),
          BlocProvider<NavCubit>(
            create: (context) {
              return getIt<NavCubit>();
            },
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [getIt<AppNavigatorObserver>()],
          //initialRoute: Routes.login,
          initialRoute: Routes.splash,
          onGenerateRoute: generateRoute,
          theme: getLightTheme(),
          darkTheme: ThemeData(),
          themeMode: ThemeMode.light,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        ),
      ),
    );
  }
}

Future<void> _configureFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: false);
    return true;
  };
  // to catch errors that happen outside of flutter context
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
      fatal: true,
    );
  }).sendPort);
}
