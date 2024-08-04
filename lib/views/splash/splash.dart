import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lumi_clips/widgets/custom_safe_area.dart';

import '../../firebase_options.dart';
import '../../resources/res.dart';
import '../home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Animation? animation;
  AnimationController? animationController;
  @override
  void initState() {
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((_) async {
      "Firebase Initialized".log();
      await Hive.initFlutter();
      await Hive.openBox("localDb");
      Future.delayed(const Duration(seconds: 3), () async {
        context.pushReplacement(const HomeScreen());
        // if (auth.currentUser != null) {
        //   await Get.putAsync<UserDataController>(() async => await UserDataController().init());
        //   Get.put(AdsController());
        //   Get.offAll(() => const BottomNav());
        // } else {
        //   if (LocalDb.onboardingViewed) {
        //     Get.offAll(() => const LoginScreen());
        //   } else {
        //     Get.offAll(() => const OnBoardingScreen());
        //   }
        // }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
          body: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              curve: Curves.ease,
              duration: const Duration(seconds: 2),
              builder: (BuildContext context, double opacity, Widget? child) {
                return Opacity(
                  opacity: opacity,
                  child: Text(
                    "LumiClips",
                    style: AppTextStyle.kHeadingLarge
                        .copyWith(color: AppColors.kPrimary, fontFamily: AppFonts.courgette, fontWeight: FontWeight.bold, fontSize: 50),
                  ).topAlign.padTop(context.h(20)),
                );
              })),
    );
  }
}
