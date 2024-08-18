import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/exports.dart';
import '../../widgets/custom_password_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthViewController>(
          init: AuthViewController(),
          builder: (controller) {
            if (Ext.isDebugMode) {
              controller.email.value.text = 'admin@lumiclips.com';
              controller.password.value.text = "Lumiclips2024";
            }
            return Form(
              key: controller.loginFormKey,
              child: ListView(
                padding: 20.padAll(),
                children: [
                  Gap(context.h(10)),
                  Text(
                    "LumiClips",
                    style: AppTextStyle.kHeadingLarge
                        .copyWith(color: AppColors.kPrimary, fontFamily: AppFonts.courgette, fontWeight: FontWeight.bold, fontSize: 50),
                  ).center,
                  Gap(context.h(4)),
                  Center(
                    child: Text(
                      'ADMIN LOGIN',
                      style: AppTextStyle.kHeadingLarge.size25,
                    ),
                  ),
                  Gap(context.h(2)),
                  CustomTextField(
                    controller: controller.email.value,
                    hintText: "Email",
                    label: "Email",
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val == null) {
                        return "Invalid Email";
                      } else {
                        if (!val.isEmail) {
                          return "Invalid Email";
                        } else {
                          return null;
                        }
                      }
                    },
                  ),
                  CustomPasswordField(
                    controller: controller.password.value,
                    hintText: "Password",
                    label: "Password",
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: (val) {
                      if (val == null) {
                        return "Incorrect password";
                      } else {
                        if (val.length < 8) {
                          return "Incorrect password";
                        } else {
                          return null;
                        }
                      }
                    },
                  ),
                  Gap(context.h(4)),
                  CustomElevatedButton(
                      title: "LOGIN",
                      onPress: () async {
                        if (controller.loginFormKey.currentState!.validate()) {
                          await controller.handleLogin();
                        }
                      }),
                  Gap(context.h(4)),
                ],
              ),
            );
          }).center,
    ).unFocus(context);
  }
}
