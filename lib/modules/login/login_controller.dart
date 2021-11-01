import 'dart:async';

import 'package:bccp_mobile_v2/core/services/auth_service.dart';
import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/services/localization_ext_service.dart';
import 'package:bccp_mobile_v2/data/provider/login/login_provider.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginController extends GetxController {
  LoginProvider _loginProvider;
  AuthService _authService = Get.find();
  HttpService _httpService = Get.find();
  final LocalizationExtService localizationExtService = Get.find();

  LoginController(LoginProvider loginProvider) {
    _loginProvider = loginProvider;
  }

  final _visibility = true.obs;
  final _user = ''.obs;
  final _pass = ''.obs;
  final showVisibility = false.obs;
  final appLanguage = ''.obs;
  final version = ''.obs;

  FocusNode focusPass = new FocusNode();
  final getStore = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    focusPass.addListener(() {
      showVisibility.value = focusPass.hasFocus;
    });
    loadAppInfo();
  }

  loadAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }

  void setUser(String value) {
    _user.value = value;
  }

  void setPass(String value) {
    _pass.value = value;
  }

  RxBool get isVisibility => this._visibility;

  RxString get user => this._user;

  RxString get pass => this._pass;

  void toggleVisibility() {
    this._visibility.value = !this._visibility.value;
  }

  Future<void> toggleAppLanguage() async {
    localizationExtService.toggleAppLanguage();
  }

  void login() async {
    if (_user.value.isBlank || _pass.value.isBlank) {
      DialogService.alert(
          title: 'Thông báo',
          message: 'Tài khoản hoặc mật khẩu không được bỏ trống');
      return;
    }
    DialogService.onShowLoading(true);
    var rs = await _httpService.login(
      userName: _user.value,
      passWord: _pass.value,
    );
    if (rs) {
      await _authService.fetchUserInfo();
      DialogService.onShowLoading(false);
      Get.offAllNamed(Routes.HOME);
    } else {
      DialogService.onShowLoading(false);
      DialogService.alert(
          title: 'Thông báo',
          message: 'Tài khoản hoặc mật khẩu không chính xác');
    }
  }
}
