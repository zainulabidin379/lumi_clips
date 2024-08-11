import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lumi_clips/helpers/exports.dart';

class DbService {
  /// Add User
  static Future<bool> addUser() async {
    var token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      var ref = FirebaseFirestore.instance.collection("users").doc(LocalDb.uid);
      await ref.set({"uid": LocalDb.uid, "token": token});
      return true;
    }
    return false;
  }

  /// logout User
  static Future logout() async {
    var ref = FirebaseFirestore.instance.collection("users").doc(LocalDb.uid);
    await ref.update({"uid": LocalDb.uid, "token": ''});
  }
}
