import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'package:get/get.dart';

import 'receiver_real_add_controller.dart';

class ReceiverRealAddBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiverRealAddController>(
      () => ReceiverRealAddController(
        commonRepository: CommonRepository(),
      ),
    );
  }
}
