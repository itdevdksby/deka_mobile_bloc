import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<DeviceInfoDomain> getDeviceInfo() async {
  try {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    final domain = DeviceInfoDomain(
        brand: allInfo['brand'],
        model: allInfo['model'],
        deviceId: await const AndroidId().getId()
    );

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      domain.deviceId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    }

    return domain;
  }on DeviceInfoDomain catch(e) {
    return e;
  }
}

class DeviceInfoDomain {
  DeviceInfoDomain({
    this.brand,
    this.model,
    this.deviceId,
    this.firebaseId,
  });

  String? brand;
  String? model;
  String? deviceId = "Unknown";
  String? firebaseId = "Unknown";
}