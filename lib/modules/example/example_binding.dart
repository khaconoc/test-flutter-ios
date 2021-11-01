import 'package:get/get.dart';

import 'example_controller.dart';

class ExampleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExampleController>(() => ExampleController());
  }
}