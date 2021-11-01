import 'package:bccp_mobile_v2/core/services/auth_service.dart';
import 'package:bccp_mobile_v2/core/services/connectivity_service.dart';
import 'package:bccp_mobile_v2/core/services/custom_dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/localization_service.dart';
import 'package:bccp_mobile_v2/core/utils/util_color.dart';
import 'package:bccp_mobile_v2/modules/splash/splash_controller.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashPage extends GetView<SplashController> {
  // void initState() {
  //   super.initState();
  //   khoiTao();
  // }
  //
  // Future<void> initServices() async {
  //   print('starting services ...');
  //   /// Here is where you put get_storage, hive, shared_pref initialization.
  //   /// or moor connection, or whatever that's async.
  //   await Get.putAsync(() => CustomDialogService().init());
  //   Get.put(ConnectivityService());
  //   print('All services started...');
  // }

  // void khoiTao() async {
  //   // await initServices();
  //   await getLanguage();
  // }
  //
  // Future<void> getLanguage() async {
  //   final getStore = GetStorage();
  //   String lang = await getStore.read('lang') ?? Get.deviceLocale.languageCode;
  //   LocalizationService.changeLocale(lang);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // UtilColor.getColorFromHex('#5581F1'),
                // UtilColor.getColorFromHex('#1153FC'),
                mainColor,
                mainColorDart
              ],
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   "assets/images/logo.png",
            //   width: 250,
            //   height: 250,
            // ),
            // SpinKitWave(
            //   color: Colors.white.withAlpha(1000),
            //   size: 40,
            // ),
            SpinKitSpinningLines(
              color: Colors.white,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
