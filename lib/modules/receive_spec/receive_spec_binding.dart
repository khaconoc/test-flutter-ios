import 'package:get/get.dart';

import 'receive_spec_controller.dart';

class ReceiveSpecBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiveSpecController>(() => ReceiveSpecController());
  }
}