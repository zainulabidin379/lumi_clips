import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumi_clips/helpers/exports.dart';
import 'package:lumi_clips/models/message.dart';
import 'package:lumi_clips/views/home/add_message.dart';
import 'package:lumi_clips/views/videos/videos.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/alert_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LumiClips",
          textAlign: TextAlign.center,
          style: AppTextStyle.kHeadingLarge
              .copyWith(color: AppColors.kPrimary, fontWeight: FontWeight.bold, fontFamily: AppFonts.courgette, fontSize: 35),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.to(() => const VideosScreen());
            },
            icon: const Icon(
              Icons.video_collection,
              color: AppColors.kBlue,
            )).padLeft(10),
        actions: [
          IconButton(
              onPressed: () {
                showAlertDialog(
                    context: context,
                    title: "Logout",
                    body: const Text("Are you sure to logout?"),
                    saveButtonTitle: "Logout",
                    saveButtonColor: AppColors.kRed,
                    onSave: () async {
                      AuthService.signOut();
                    });
              },
              icon: const Icon(
                Icons.logout,
                color: AppColors.kBlack,
              )).padRight(10)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.kPrimary,
        onPressed: () => Get.to(() => const AddMessage()),
        child: const Icon(
          Icons.add,
          color: AppColors.kWhite,
        ),
      ),
      body: StreamBuilder<dynamic>(
          stream: FirebaseFirestore.instance.collection("messages").orderBy("no").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Loading().center;
            }
            List<MessageModel> messages = snapshot.data.docs.map<MessageModel>((e) => MessageModel.fromMap(e)).toList();
            return ListView(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 70),
              children: List.generate(messages.length, (index) => messageCard(messages[index])),
            );
          }),
    );
  }

  Widget messageCard(MessageModel message) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      margin: 10.padBottom(),
      decoration: BoxDecoration(border: Border.all(color: AppColors.kGrey, width: 1), borderRadius: 20.circular()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${message.no.ordinal} SMS",
                style: AppTextStyle.kHeadingText.applyColor(AppColors.kPrimary),
              ),
              IconButton(
                  onPressed: () => Get.to(() => AddMessage(
                        message: message,
                      )),
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                  ))
            ],
          ),
          Text.rich(TextSpan(children: [
            TextSpan(text: "Message Body: ", style: AppTextStyle.kDefaultBodyText.copyWith(fontFamily: AppFonts.bold)),
            ...generateTextSpans(message.body),
          ])),
          const Gap(5),
          Text.rich(TextSpan(children: [
            TextSpan(text: "Delay after registration: ", style: AppTextStyle.kDefaultBodyText.copyWith(fontFamily: AppFonts.bold)),
            TextSpan(
                text: message.delay.toString(), style: AppTextStyle.kDefaultBodyText.copyWith(fontFamily: AppFonts.bold, color: AppColors.kPrimary)),
            TextSpan(text: " Minutes", style: AppTextStyle.kDefaultBodyText.copyWith(color: AppColors.kBlack.withOpacity(0.7))),
          ])),
          const Gap(15)
        ],
      ),
    );
  }

  List<TextSpan> generateTextSpans(String text) {
    const urlPattern = r'(?:(?:https?|ftp):\/\/)?(?:[\w-]+\.)+[a-z]{2,6}(?:\/\S*)?';
    final regExp = RegExp(urlPattern);

    List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    for (RegExpMatch match in regExp.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: AppTextStyle.kDefaultBodyText.copyWith(color: AppColors.kBlack.withOpacity(0.7)),
        ));
      }

      spans.add(TextSpan(
        text: match.group(0),
        style: AppTextStyle.kDefaultBodyText.copyWith(
          color: AppColors.kBlue,
          fontFamily: AppFonts.semibold,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            launchUrl(Uri.parse(match.group(0).toString()));
          },
      ));

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: AppTextStyle.kDefaultBodyText.copyWith(color: AppColors.kBlack.withOpacity(0.7)),
      ));
    }

    return spans;
  }
}
