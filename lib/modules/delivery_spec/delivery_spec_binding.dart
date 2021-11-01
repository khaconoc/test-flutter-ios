import 'package:bccp_mobile_v2/data_service/repositories/delivery/delivery_repository.dart';
import 'package:bccp_mobile_v2/data_service/repositories/receive/receive_repository.dart';
import 'package:bccp_mobile_v2/modules/delivery_spec/delivery_spec_controller.dart';
import 'package:get/get.dart';

class DeliverySpecBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliverySpecController>(() => DeliverySpecController(
      deliverRepository: DeliverRepository()
    ));
  }
}