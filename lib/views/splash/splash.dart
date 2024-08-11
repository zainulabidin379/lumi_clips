import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lumi_clips/services/notifications/notification.dart';
import 'package:lumi_clips/widgets/custom_safe_area.dart';

import '../../firebase_options.dart';
import '../../helpers/exports.dart';
import '../../main.dart';
import '../home/home.dart';
import '../videoPreview/video_preview.dart';

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
      await LocalDb.setUid();
      await LocalNotifications.init();
      1.delay();

      if (widget.url != null) {
        await navigatorKey.currentState?.push(MaterialPageRoute<void>(
          builder: (BuildContext context) => VideoPreview(url: widget.url!),
        ));
      } else {
        await navigatorKey.currentState?.push(MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomeScreen(),
        ));
      }
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
