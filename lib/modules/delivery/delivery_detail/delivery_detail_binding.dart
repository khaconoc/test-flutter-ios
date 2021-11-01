import 'package:bccp_mobile_v2/data_service/repositories/delivery/delivery_repository.dart';
import 'package:bccp_mobile_v2/data_service/repositories/receive/receive_repository.dart';
import 'package:bccp_mobile_v2/modules/delivery/delivery_detail/delivery_detail_controller.dart';
import 'package:get/get.dart';

class DeliveryDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryDetailController>(() => DeliveryDetailController(
      deliverRepository: DeliverRepository()
    ));
  }
}