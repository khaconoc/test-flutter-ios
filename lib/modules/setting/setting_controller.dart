import 'package:bccp_mobile_v2/core/services/auth_service.dart';
import 'package:bccp_mobile_v2/core/services/config_server_service.dart';
import 'package:bccp_mobile_v2/core/services/config_service.dart';
import 'package:bccp_mobile_v2/core/services/custom_dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/services/identity_service.dart';
import 'package:bccp_mobile_v2/core/services/localization_service.dart';
import 'package:bccp_mobile_v2/data_service/repositories/delivery/delivery_repository.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController {
  IdentityService _identityService = Get.find();
  HttpService _httpService = Get.find();
  ConfigService _configService = Get.find();
  ConfigServerService configServerService = Get.find();

  final keepLogin = true.obs;
  final devMode = false.obs;
  final appLanguage = 'vi'.obs;
  final version = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    loadAppInfo();
  }

  loadAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }

  @override
  void onReady() async {
    super.onReady();
    await khoiTao();
  }

  Future<void> khoiTao() async {
    DialogService.onShowLoading(true);
    String lang = _configService.appLanguage;
    bool keepLoginStore = _configService.keepLogin;
    bool devModeStore = _configService.devMode;
    appLanguage.value = lang;
    keepLogin.value = keepLoginStore;
    devMode.value = devModeStore;
    DialogService.onShowLoading(false);
  }

  void toggleKeepLogin(value) {
    keepLogin.value = value;
    _configService.setConfig(keepLogin: keepLogin.value);
  }

  void toggleDevMode(value) {
    devMode.value = value;
    _configService.setConfig(devMode: devMode.value);
  }

  void onChangeLanguage(String code) {
    appLanguage.value = code;
    LocalizationService.changeLocale(code);
    _configService.setConfig(appLanguage: code);
  }

  void onLogout() async {
    var confirm = await DialogService.confirm(message: 'logout'.tr);
    if(!confirm) return;
    _identityService.removeIdentity();
    _httpService.cancelScheduleRefreshToken();
    Get.offAllNamed(Routes.LOGIN);
  }

  void onCheckUpdate() async {
    var rs = await configServerService.checkVersion();
    if(rs['isHasNewVersion']) {
      var conf = await DialogService.confirm(message: 'Có một bản cập nhật mới, bạn có muốn cập nhật không?');
      if (conf) {
        launch(rs['urlDownload']);
      }
    } else {
      DialogService.alert(message: 'Phiên bản bạn đang sử dụng là mới nhất');
    }
  }
}
