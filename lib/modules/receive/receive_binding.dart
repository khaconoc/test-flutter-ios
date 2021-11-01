import 'package:bccp_mobile_v2/modules/receive/receive_controller.dart';
import 'package:get/get.dart';

class ReceiveBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiveController>(() => ReceiveController());
  }
}