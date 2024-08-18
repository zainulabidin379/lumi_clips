import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lumi_clips/views/auth/login.dart';
import 'package:lumi_clips/views/home/home.dart';

import '../../firebase_options.dart';
import '../../helpers/exports.dart';

class SplashScreen extends StatefulWidget {
  final String? url;
  const SplashScreen({super.key, this.url});

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
      2.delay();
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offAll(() => const HomeScreen());
      } else {
        Get.offAll(() => const LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            curve: Curves.ease,
            duration: const Duration(seconds: 1),
            builder: (BuildContext context, double opacity, Widget? child) {
              return Opacity(
                opacity: opacity,
                child: Text(
                  "LumiClips",
                  style: AppTextStyle.kHeadingLarge
                      .copyWith(color: AppColors.kPrimary, fontFamily: AppFonts.courgette, fontWeight: FontWeight.bold, fontSize: 50),
                ),
              );
            }).center);
  }
}
