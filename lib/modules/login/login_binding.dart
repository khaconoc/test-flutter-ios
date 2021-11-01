import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/data/provider/login/login_provider.dart';
import 'package:bccp_mobile_v2/data/repositories/login/login_repository.dart';
import 'package:bccp_mobile_v2/modules/login/login_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(LoginProvider(LoginRepository())));
  }
}