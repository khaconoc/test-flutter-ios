import 'package:bccp_mobile_v2/modules/delivery/delivery_controller.dart';
import 'package:get/get.dart';

class DeliveryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryController>(() => DeliveryController());
  }
}