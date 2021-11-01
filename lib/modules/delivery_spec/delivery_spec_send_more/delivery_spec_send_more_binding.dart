import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'package:bccp_mobile_v2/data_service/repositories/delivery_special/delivery_spec_repository.dart';
import 'package:get/get.dart';

import 'delivery_spec_send_more_controller.dart';

class DeliverySpecSendMoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliverySpecSendMoreController>(
      () => DeliverySpecSendMoreController(
        deliverSpecRepository: DeliverySpecRepository(),
        commonRepository: CommonRepository(),
      ),
    );
  }
}
