import 'package:get/get.dart';

import 'delivery_history_controller.dart';
import 'package:bccp_mobile_v2/data_service/repositories/delivery_history/dlivery_history_repository.dart';

class DeliveryHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryHistoryController>(() => DeliveryHistoryController(
      deliveryHistoryRepository: DeliveryHistoryRepository()
    ));
  }
}