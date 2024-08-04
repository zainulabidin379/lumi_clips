import 'package:hive_flutter/hive_flutter.dart';

class LocalDb {
  static Box dbBox = Hive.box("localDb");

  static bool qrCodeScanned = dbBox.get("qrCodeScanned", defaultValue: false);

  /// Update Onboarding Viewed
  static Future updateQrCodeScannedStatus(bool scanned) async {
    await dbBox.put("qrCodeScanned", scanned);
    qrCodeScanned = dbBox.get("qrCodeScanned", defaultValue: false);
  }
}
