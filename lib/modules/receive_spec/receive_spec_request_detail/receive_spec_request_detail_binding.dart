import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'file:///D:/DATA/DHNI/source/bccp_mobile/lib/data_service/repositories/receive_special/receive_spec_repository.dart';
import 'package:get/get.dart';

import 'receive_spec_request_detail_controller.dart';

class ReceiveSpecRequestDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiveSpecRequestDetailController>(() => ReceiveSpecRequestDetailController(
      receiveSpecRepository: ReceiveSpecRepository(),
      commonRepository: CommonRepository()
    ));
  }
}