import 'package:get/get.dart';

import 'web_view_custom_controller.dart';

class WebViewCustomBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebViewCustomController>(() => WebViewCustomController());
  }
}