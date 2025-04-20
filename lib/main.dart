import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_bloc_observer.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/routes/app_router.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flower_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flower_app/features/nav/presentation/cubit/nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/theme_data/theme_data_light.dart';

// global variable
bool? isUserLoggedInAutomatically;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Bloc.observer = AppBlocObserver();
  await configureDependencies().then((_) async {
   isUserLoggedInAutomatically = await getIt<AuthCubit>().isUserLoggedIn();
  },);

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
          BlocProvider<NavCubit>(create: (BuildContext context) => getIt<NavCubit>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
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
