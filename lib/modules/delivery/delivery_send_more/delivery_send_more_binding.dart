import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'package:bccp_mobile_v2/data_service/repositories/delivery/delivery_repository.dart';
import 'package:get/get.dart';

import 'delivery_send_more_controller.dart';

class DeliverySendMoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliverySendMoreController>(
      () => DeliverySendMoreController(
        deliverRepository: DeliverRepository(),
        commonRepository: CommonRepository(),
      ),
    );
  }
}
