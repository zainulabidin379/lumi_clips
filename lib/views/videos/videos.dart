import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helpers/exports.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Videos",
          style: AppTextStyle.kHeadingLarge.applyColor(AppColors.kPrimary),
        ),
      ),
      body: StreamBuilder<dynamic>(
          stream: FirebaseFirestore.instance.collection("videos").orderBy("no").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Loading().center;
            }
            List videos = snapshot.data.docs;
            return ListView(
              padding: 15.padAll(),
              children: List.generate(
                  videos.length,
                  (index) => Container(
                        padding: 15.padAll(),
                        margin: 10.padBottom(),
                        decoration: BoxDecoration(border: Border.all(color: AppColors.kGrey, width: 1), borderRadius: 20.circular()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(text: "Video: ", style: AppTextStyle.kDefaultBodyText.copyWith(fontFamily: AppFonts.regular)),
                              TextSpan(
                                  text: int.parse(videos[index]["no"].toString()).ordinal,
                                  style: AppTextStyle.kLargeBodyText.copyWith(fontFamily: AppFonts.bold, color: AppColors.kPrimary)),
                            ])),
                            const Gap(5),
                            Row(
                              children: [
                                Text.rich(TextSpan(children: [
                                  TextSpan(text: "Short URL: ", style: AppTextStyle.kDefaultBodyText.copyWith(fontFamily: AppFonts.regular)),
                                  TextSpan(
                                    text: videos[index]["shortUrl"],
                                    style: AppTextStyle.kDefaultBodyText.copyWith(fontFamily: AppFonts.bold, color: AppColors.kBlue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(Uri.parse(videos[index]["shortUrl"]));
                                      },
                                  ),
                                ])).flexible,
                                IconButton(
                                    onPressed: () async {
                                      await Ext.copy(videos[index]["shortUrl"]);
                                      ShowSnackbar.success("URL Copied!");
                                    },
                                    icon: const Icon(Icons.copy))
                              ],
                            ),
                          ],
                        ),
                      )),
            );
          }),
    );
  }
}
