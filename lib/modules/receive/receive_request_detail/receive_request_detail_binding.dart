import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'package:bccp_mobile_v2/data_service/repositories/receive/receive_repository.dart';
import 'package:bccp_mobile_v2/modules/receive/receive_request_detail/receive_request_detail_controller.dart';
import 'package:get/get.dart';

class ReceiveRequestDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiveRequestDetailController>(() => ReceiveRequestDetailController(
      receiveRepository: ReceiveRepository(),
      commonRepository: CommonRepository()
    ));
  }
}