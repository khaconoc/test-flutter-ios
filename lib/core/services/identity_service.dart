import 'dart:async';

import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:bccp_mobile_v2/data/model/login/user_model.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class IdentityService extends GetxService {
  String token = '';
  String refreshToken = '';
  Timer timer;

  Future<IdentityService> init() async {
    final getStore = GetStorage();
    token = await getStore.read(kToken) ?? '';
    refreshToken = await getStore.read(kRefreshToken) ?? '';
    return this;
  }

  void setIdentity({String token, String refreshToken}) {

    this.token = token;
    this.refreshToken = refreshToken;

    /// luu vao store
    final getStore = GetStorage();
    getStore.write(kToken, token);
    getStore.write(kRefreshToken, refreshToken);
  }

  void removeIdentity() {
    this.token = null;
    this.refreshToken = null;

    /// luu vao store
    final getStore = GetStorage();
    getStore.remove(kToken);
    getStore.remove(kRefreshToken);
  }

  int getCountTimeLive() {
    DateTime now = DateTime.now();
    DateTime expirationDate = JwtDecoder.getExpirationDate(this.token);
    return expirationDate.millisecondsSinceEpoch - now.millisecondsSinceEpoch - kTimeExpired;
  }

  int getCountTimeRefresh() {
    DateTime now = DateTime.now();
    DateTime expirationDate = JwtDecoder.getExpirationDate(this.token);
    print('expirationDate.millisecondsSinceEpoch: ${expirationDate.millisecondsSinceEpoch}');
    print('now.millisecondsSinceEpoch: ${now.millisecondsSinceEpoch}');
    return expirationDate.millisecondsSinceEpoch - now.millisecondsSinceEpoch - kTimeRefresh;
  }

  bool isTokenLive() {
    if (getCountTimeLive() > 0 ) {
      return true;
    }
    return false;
  }
}
