import 'dart:async';

import 'package:bccp_mobile_v2/core/services/auth_service.dart';
import 'package:bccp_mobile_v2/core/services/config_server_service.dart';
import 'package:bccp_mobile_v2/core/services/config_service.dart';
import 'package:bccp_mobile_v2/core/services/custom_dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/services/identity_service.dart';
import 'package:bccp_mobile_v2/core/services/localization_ext_service.dart';
import 'package:bccp_mobile_v2/core/services/localization_service.dart';
import 'package:bccp_mobile_v2/core/services/position_service.dart';
import 'package:bccp_mobile_v2/modules/example/example_page.dart';
import 'package:bccp_mobile_v2/modules/home/home_page.dart';
import 'package:bccp_mobile_v2/modules/splash/splash_page.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'core/services/connectivity_service.dart';
import 'core/services/utils_service.dart';
import 'data_service/repositories/common/common_repositoty.dart';

void main() async {
  // Intl.defaultLocale = 'pt_BR';
  await GetStorage.init();
  await initServices();
  // runZonedGuarded(() {
  //   runApp(MyApp());
  // }, (Object error, StackTrace stack) {
  //   // myBackend.sendError(error, stack);
  //   DialogService.onShowLoading(false);
  //   DialogService.showSnackBar('Xuất hiện lỗi trong quá trình xử lý', StatusSnackBar.error);
  //   print(error);
  //   print(stack);
  // });

  runApp(MyApp());
}

Future<void> initServices() async {
  print('starting services ...');

  await Get.putAsync(() => UtilsService().init());
  await Get.putAsync(() => ConfigService().init());
  await Get.putAsync(() => IdentityService().init());
  await Get.putAsync<HttpService>(() => HttpService().init(Dio()));
  await Get.putAsync(() => AuthService().init());
  Get.putAsync(() => CustomDialogService().init());
  Get.put(ConnectivityService());

  await Get.putAsync(() => ConfigServerService().init());

  await Get.putAsync(() => LocalizationExtService().init());
  await Get.putAsync(() => PositionService().init());
  print('All services started...');
}

// class AppBinding extends Bindings {
//
//   @override
//   void dependencies() {
//     injectService();
//   }
//
//   void injectService() {
//     // Get.put(AuthService());
//     Get.put(ConnectivityService());
//   }
// }

class MyApp extends StatelessWidget {
  // const MyApp({
  //   // this.appConfig,
  // });

  // final AppConfig appConfig;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      // statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.rightToLeft,
        transitionDuration: Duration(milliseconds: 200),


        // home: HomePage(),
        home: ExamplePage(),
        getPages: AppPages.pages,
        initialRoute: Routes.SPLASH,
        // initialRoute: Routes.HOME,

        theme: appThemeData,

        locale: LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),

        // initialBinding: AppBinding(),
      ),
    );
  }
}
