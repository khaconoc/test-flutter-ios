import 'package:bccp_mobile_v2/core/services/auth_service.dart';
import 'package:bccp_mobile_v2/core/services/connectivity_service.dart';
import 'package:bccp_mobile_v2/core/services/custom_dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/services/localization_ext_service.dart';
import 'package:bccp_mobile_v2/data/provider/login/login_provider.dart';
import 'package:bccp_mobile_v2/data/repositories/login/login_repository.dart';
import 'package:bccp_mobile_v2/modules/splash/splash_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() async {
    // print('Starting all service_______________________');
    // await Get.putAsync(() => AuthService().init());
    // Get.putAsync(() => CustomDialogService().init());
    // Get.put(ConnectivityService());
    // await Get.putAsync<HttpService>(() => HttpService().init(Dio()));
    // await Get.putAsync(() => LocalizationExtService().init());
    // print('Started all service_______________________');
    Get.put<SplashController>(SplashController(
      loginProvider: LoginProvider(LoginRepository())
    ));
    // Get.lazyPut<SplashController>(() => SplashController());
  }
}