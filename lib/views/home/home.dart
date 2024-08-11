import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lumi_clips/helpers/exports.dart';
import 'package:lumi_clips/services/db/db.dart';
import 'package:lumi_clips/services/notifications/notification.dart';
import 'package:lumi_clips/widgets/custom_elevated_button.dart';
import 'package:lumi_clips/widgets/custom_safe_area.dart';
import 'package:lumi_clips/widgets/snackbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: ValueListenableBuilder(
            valueListenable: LocalDb.dbBox.listenable(),
            builder: (context, box, _) {
              return StreamBuilder<dynamic>(
                  stream: FirebaseFirestore.instance.collection("users").doc(box.get("uid")).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          titleWidget(context, ''),
                          Gap(context.h(5)),
                          const Loading(),
                        ],
                      ).padAll(15);
                    }
                    if (snapshot.data.exists) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          titleWidget(context, 'You will receive notifications about the journey of the Lumi.'),
                          Gap(context.h(5)),
                        ],
                      ).padAll(15);
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        titleWidget(context, ''),
                        Gap(context.h(5)),
                        CustomElevatedButton(
                            title: "Register",
                            fontSize: 24,
                            width: 200,
                            height: 70,
                            onPress: () {
                              LocalNotifications.requestPermission().then((val) async {
                                if (val.authorizationStatus == AuthorizationStatus.authorized) {
                                  await DbService.addUser();
                                } else {
                                  ShowSnackbar.error("Please allow notifications to register");
                                }
                              });
                            })
                      ],
                    ).padAll(15);
                  });
            }),
      ),
    );
  }

  Container titleWidget(BuildContext context, String subtitle) {
    return Container(
      height: subtitle.isNotEmpty ? 200 : 120,
      width: context.screenWidth,
      margin: context.h(subtitle.isNotEmpty ? 5 : 10).padTop(),
      decoration: BoxDecoration(
        color: AppColors.kWhite.withOpacity(0.5),
        borderRadius: 25.circular(),
      ),
      child: ClipRRect(
        borderRadius: 25.circular(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: -25,
              top: -25,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.kPrimary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: -35,
              bottom: -35,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.kPrimary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "LumiClips",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.kHeadingLarge
                      .copyWith(color: AppColors.kPrimary, fontWeight: FontWeight.bold, fontFamily: AppFonts.courgette, fontSize: 35),
                ),
                subtitle.isNotEmpty
                    ? Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.kMediumBodyText.copyWith(color: AppColors.kBlack.withOpacity(0.5)),
                      ).padTop(10)
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
