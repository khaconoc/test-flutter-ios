import 'dart:async';

import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConfigService extends GetxService {
  String appLanguage = '';
  String version = '';
  bool keepLogin = false;
  bool devMode = false;

  Future<ConfigService> init() async {
    final getStore = GetStorage();
    appLanguage = await getStore.read(kAppLanguage) ?? Get.deviceLocale.languageCode;
    keepLogin = await getStore.read(kKeepLogin) ?? false;
    devMode = await getStore.read(kDevMode) ?? false;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    return this;
  }

  void setConfig({String appLanguage, bool keepLogin, bool devMode, String version}) {
    final getStore = GetStorage();
    if(appLanguage != null) {
      this.appLanguage = appLanguage;
      getStore.write(kAppLanguage, appLanguage);
    }
    if(keepLogin != null) {
      this.keepLogin = keepLogin;
      getStore.write(kKeepLogin, keepLogin);
    }

    if(devMode != null) {
      this.devMode = devMode;
      getStore.write(kDevMode, devMode);
    }
    if(version != null) {
      this.version = version;
      getStore.write(kVersion, version);
    }
  }

}