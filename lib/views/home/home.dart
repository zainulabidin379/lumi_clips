import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lumi_clips/controllers/home_controller.dart';
import 'package:lumi_clips/resources/res.dart';
import 'package:lumi_clips/widgets/custom_elevated_button.dart';
import 'package:lumi_clips/widgets/custom_safe_area.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> scanBarcode(BuildContext context) async {
    try {
      await FlutterBarcodeScanner.scanBarcode(
        '#FB4B4E',
        'Cancel',
        false,
        ScanMode.QR,
      ).then((val) {
        val.log();
        if (val != '-1') {
          if (val == "LumiClips") {
            LocalDb.updateQrCodeScannedStatus(true);
            Ext.showMessageSnackbar("Dive into the Lumi Experience", context);
          } else {
            Ext.showErrorSnackbar("Invalid QR Code", context);
          }
        }
      });
    } on PlatformException {
      'Failed to get platform version.'.log();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: ValueListenableBuilder(
            valueListenable: LocalDb.dbBox.listenable(),
            builder: (context, box, _) {
              if (!box.get("qrCodeScanned", defaultValue: false)) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    topWidget("LumiClips", "Scan QR Code", context),
                    Image.asset(
                      ImageAssets.qrCode,
                      height: context.w(80) > 300 ? 300 : context.w(80),
                    ),
                    CustomElevatedButton(
                        title: "SCAN NOW",
                        width: 200,
                        onPress: () {
                          scanBarcode(context);
                        })
                  ],
                ).padAll(15);
              }
              return GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (controller) {
                    return Column(
                      children: [
                        topWidget("LumiClips", "Dive into the Experience", context).padOnly(left: 15, right: 15, top: 15),
                        PageView.builder(
                          itemCount: controller.posts.length,
                          controller: controller.pageController,
                          itemBuilder: (context, index) => Stack(
                            children: [
                              CustomCacheImage(
                                imageUrl: controller.posts[index]["img"]!,
                                width: context.screenWidth,
                                height: context.screenHeight,
                                borderRadius: 25,
                              ),
                              Positioned.fill(
                                child: Container(
                                  width: context.screenWidth,
                                  height: context.screenHeight,
                                  decoration: BoxDecoration(color: AppColors.kBlack.withOpacity(0.5), borderRadius: 25.circular()),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(10),
                                  Text(
                                    "Video Title Goes here",
                                    style: AppTextStyle.kHeadingText.copyWith(
                                      color: AppColors.kWhite,
                                    ),
                                  ),
                                  Text(
                                    10.loremIpsum(),
                                    style: AppTextStyle.kDefaultBodyText
                                        .copyWith(color: AppColors.kWhite.withOpacity(0.7), fontFamily: AppFonts.regular),
                                  ),
                                ],
                              ).padAll(15),
                              Positioned(
                                bottom: 15,
                                right: 15,
                                child: IconButton.filled(
                                    onPressed: () {
                                      launchUrlString(controller.posts[index]["videoUrl"]!);
                                    },
                                    color: AppColors.kPrimary,
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      size: 50,
                                    )),
                              )
                            ],
                          ).padAll(15),
                        ).flexible,
                        SmoothPageIndicator(
                          controller: controller.pageController,
                          count: controller.posts.length,
                          effect:
                              const ExpandingDotsEffect(activeDotColor: AppColors.kPrimary, dotColor: AppColors.kGrey, dotHeight: 10, dotWidth: 10),
                        ),
                        const Gap(15)
                      ],
                    );
                  });
            }),
      ),
    );
  }

  Widget topWidget(String title, String subtitle, BuildContext context) {
    return Container(
      height: 120,
      width: context.screenWidth,
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
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.kHeadingLarge.copyWith(color: AppColors.kPrimary, fontFamily: AppFonts.courgette, fontSize: 35),
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.kLargeBodyText.copyWith(color: AppColors.kGrey, fontFamily: AppFonts.semibold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
