import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'package:bccp_mobile_v2/data_service/repositories/delivery/delivery_repository.dart';
import 'package:bccp_mobile_v2/data_service/repositories/delivery_special/delivery_spec_repository.dart';
import 'package:get/get.dart';

import 'delivery_spec_send_one_controller.dart';

class DeliverySpecSendOneBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliverySpecSendOneController>(
      () => DeliverySpecSendOneController(
        deliverSpecRepository: DeliverySpecRepository(),
        commonRepository: CommonRepository(),
      ),
    );
  }
}
