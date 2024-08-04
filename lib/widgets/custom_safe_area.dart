import 'package:flutter/material.dart';
import 'package:lumi_clips/resources/res.dart';

class CustomSafeArea extends StatelessWidget {
  final Widget child;
  const CustomSafeArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                ImageAssets.bg,
              ),
              fit: BoxFit.cover)),
      child: SafeArea(child: child),
    );
  }
}
