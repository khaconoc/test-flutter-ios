import 'package:get/get.dart';

import 'test_control_controller.dart';

class TestControlBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestControlController>(() => TestControlController());
  }
}