import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'package:bccp_mobile_v2/data_service/repositories/delivery/delivery_repository.dart';
import 'package:get/get.dart';

import 'delivery_send_one_controller.dart';

class DeliverySendOneBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliverySendOneController>(
      () => DeliverySendOneController(
        deliverRepository: DeliverRepository(),
        commonRepository: CommonRepository(),
      ),
    );
  }
}
