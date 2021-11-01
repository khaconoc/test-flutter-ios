import 'dart:async';

import 'package:bccp_mobile_v2/core/services/identity_service.dart';
import 'package:bccp_mobile_v2/data/model/login/user_model.dart';
import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import 'http_service.dart';

class AuthService extends GetxService {
  UserModel _userModel;
  HttpService _httpService = Get.find();
  IdentityService _identityService = Get.find();

  Future<AuthService> init() async {
    // final getStore = GetStorage();
    // token = await getStore.read('token') ?? '';
    // refreshToken = await getStore.read('refreshToken') ?? '';
    return this;
  }

  set setUserInfo(UserModel userModel) => _userModel = userModel;

  get getUserInfo => _userModel;

  UserModel getCurrentUser() => _userModel;

  void logout() {

  }

  Future<void> fetchUserInfo() async {
    String _url = '${BaseRepository.userInfoApi}';
    var rs = await _httpService.dio.get(
      _url,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return true;
        },
      ),) as Response;

    if (rs.statusCode == 200) {
      setUserInfo = UserModel.fromJson(rs.data);
    }
  }
}