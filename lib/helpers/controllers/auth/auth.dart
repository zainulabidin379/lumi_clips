import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumi_clips/views/home/home.dart';

import '../../exports.dart';

class AuthViewController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();

  final email = TextEditingController().obs;
  final password = TextEditingController().obs;

  @override
  void dispose() {
    email.value.dispose();
    password.value.dispose();
    super.dispose();
  }

  void clearControllers() {
    email.value.clear();
    password.value.clear();
  }

  // Handle Login
  Future handleLogin() async {
    loadingDialog("Authenticating...");
    await AuthService.login(email.value.text.trim(), password.value.text.trim()).then((value) async {
      if (value != null) {
        Get.close(1);
        ShowSnackbar.error(
          value,
        );
      } else {
        Get.offAll(() => const HomeScreen());
      }
    });
  }
}
