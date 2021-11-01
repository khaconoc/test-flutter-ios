import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:bccp_mobile_v2/core/services/auth_service.dart';
import 'package:bccp_mobile_v2/core/services/config_service.dart';
import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/services/identity_service.dart';
import 'package:bccp_mobile_v2/core/services/localization_ext_service.dart';
import 'package:bccp_mobile_v2/core/services/position_service.dart';
import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:bccp_mobile_v2/data/provider/login/login_provider.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashController extends GetxController {
  final ConfigService _configService = Get.find();
  final IdentityService _identityService = Get.find();
  final AuthService _authService = Get.find();
  final HttpService _httpService = Get.find();
  final PositionService _positionService = Get.find();
  final LocalizationExtService _localizationExtService = Get.find();
  final LoginProvider loginProvider;

  SplashController({this.loginProvider});

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    _localizationExtService.changeAppLanguage(lang: _localizationExtService.appLanguage.value);

    await onHandlerPosition();

    onIdentityVerification();
  }

  onHandlerPosition() async {
    var rs = await _positionService.getPositionStatus();
    if(rs != PositionStatus.active) {
      var rs = await DialogService.confirm(message: 'Không thể truy cập vị trí\n Mở cài đặt vị trí?');
      if(rs) {
        await AppSettings.openAppSettings();
        await onHandlerPosition();
      } else {
        // exit(0);
        SystemNavigator.pop();
      }
    }
  }

  void onIdentityVerification() async {
    if(_identityService.token == null || _identityService.token == '') {
      Get.offAllNamed(Routes.LOGIN);
      return;
    }

    /// token con song
    /// + lay thong tin user
    /// + lam moi token
    if(_identityService.isTokenLive()) {
      await _authService.fetchUserInfo();
      _httpService.fetchNewToken();
    }
    /// neu token het han
    else {
      /// neu khong duy tri dang nhap -> page login
      if(!_configService.keepLogin) {
        Get.offAllNamed(Routes.LOGIN);
        return;
      }
      /// neu duy tri dang nhap
      /// + lam moi token
      /// + lay thong tin user
      else {
        await _httpService.fetchNewToken();
        await _authService.fetchUserInfo();
      }
    }
    Get.offAllNamed(Routes.HOME);
  }

  // bool onCheckTokenExpired() {
  //   DateTime now = DateTime.now();
  //   DateTime expirationDate = JwtDecoder.getExpirationDate(_authService.token);
  //   print('so sanh thoi gian het han ${expirationDate.millisecondsSinceEpoch - now.millisecondsSinceEpoch} <= $kTimeExpired:::: ${expirationDate.millisecondsSinceEpoch - now.millisecondsSinceEpoch <= kTimeExpired}');
  //   if(expirationDate.millisecondsSinceEpoch - now.millisecondsSinceEpoch <= kTimeExpired) {
  //     return true;
  //   }
  //   return false;
  // }
}
