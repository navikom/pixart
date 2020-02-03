import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceInfoService {
  static Map<String, String> info;

  Future<Map<String, String>> get deviceInfo async {
    if (DeviceInfoService.info != null) {
      return DeviceInfoService.info;
    }

    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo info = await deviceInfo.androidInfo;
        DeviceInfoService.info = Map.of({
          'androidId': info.androidId,
          'release': info.version.release,
          'sdk': info.version.sdkInt.toString(),
          'manufacturer': info.manufacturer,
          'brand': info.brand,
          'model': info.model,
          'device': info.device
        });
      } else if (Platform.isIOS) {
        IosDeviceInfo info = await deviceInfo.iosInfo;
        DeviceInfoService.info = Map.of({
          'name': info.name,
          'systemName': info.systemName,
          'systemVersion': info.systemVersion,
          'model': info.model,
          'localizedModel': info.localizedModel,
          'vendorId': info.identifierForVendor,
          'release': info.utsname.release,
        });
      }
    } catch (e) {
      print('Device info error');
      DeviceInfoService.info = new Map();
    }
    return DeviceInfoService.info;
  }
}
