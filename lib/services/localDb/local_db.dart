import 'package:hive_flutter/hive_flutter.dart';
import 'package:lumi_clips/helpers/exports.dart';

class LocalDb {
  static Box dbBox = Hive.box("localDb");

  static String uid = dbBox.get("uid", defaultValue: '');

  /// Update Onboarding Viewed
  static Future setUid() async {
    if (uid.isEmpty) {
      var id = Ext.uniqueId();
      await dbBox.put("uid", id);
      uid = await dbBox.get("uid", defaultValue: '');
      "UID Set".log();
    } else {
      "UID: $uid".log();
    }
  }
}
