import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../views/auth/login.dart';

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static String uid() {
    final User user = auth.currentUser!;
    final uid = user.uid;

    return uid;
  }

  static String getUserEmail() {
    final User user = auth.currentUser!;
    final email = user.email ?? "";
    return email;
  }

  static Future login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return getAuthExceptionMessage(e.code);
    }
    return null;
  }

  static Future signOut() async {
    try {
      Get.offAll(
        () => const LoginScreen(),
      );
      await auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  static String getAuthExceptionMessage(String code) {
    switch (code) {
      case "invalid-email":
        return "Email address is invalid 😧";

      case "user-disabled":
        return "User is disabled 🚫";

      case "user-not-found":
        return "No user found with this email ⛔";

      case "wrong-password":
        return "Wrong email/password combination 🙁";

      case "email-already-in-use":
        return "Email already used 😧";

      case "weak-password":
        return "Your password is weak 🙁";

      case "operation-not-allowed":
        return "Operation is not allowed 🙁";

      case "too-many-requests":
        return "Too many requests, try again later 🙅";

      case "account-exists-with-different-credential":
        return "Account exist with different provider 🤦";

      case "invalid-credential":
        return "Your credentials are invalid 🙁";

      case "wrong-number":
        return "Your phone number is invalid 🙁";

      case "invalid-verification-code":
        return "Your OTP is not correct 🙅";

      case "invalid-verification-id":
        return "Your phone verification ID is invalid 🙅";

      default:
        return "Something went wrong! Please try again 😧";
    }
  }
}
