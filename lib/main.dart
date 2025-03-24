import 'package:flower_app/core/routes/app_router.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/injectable.dart';
import 'core/theme/theme_data/theme_data_light.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (con, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.signup,
        onGenerateRoute: generateRoute,
        theme: getLightTheme(),
        darkTheme: ThemeData(),
        themeMode: ThemeMode.light,
      ),
    );
  }
}
