import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'resources/res.dart';
import 'views/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //for setting orientation to portrait only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LumiClips",
      theme: ThemeData(
          fontFamily: AppFonts.regular,
          colorSchemeSeed: Ext.getMaterialColor(AppColors.kPrimary),
          iconButtonTheme: IconButtonThemeData(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.kWhite.withOpacity(0.3)))),
          scaffoldBackgroundColor: AppColors.transparent,
          appBarTheme: const AppBarTheme(backgroundColor: AppColors.transparent, surfaceTintColor: AppColors.transparent)),
      defaultTransition: Transition.cupertino,
      home: const SplashScreen(),
    );
  }
}
