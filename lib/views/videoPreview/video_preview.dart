import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumi_clips/views/home/home.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatefulWidget {
  final String url;
  const VideoPreview({super.key, required this.url});

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    ));

    flickManager.flickVideoManager!.videoPlayerController?.addListener(_checkVideoEnd);
  }

  void _checkVideoEnd() async {
    if (flickManager.flickVideoManager?.isVideoEnded ?? false) {
      Get.offAll(() => const HomeScreen());
    }
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) => Get.offAll(() => const HomeScreen()),
        child: FlickVideoPlayer(flickManager: flickManager));
  }
}
