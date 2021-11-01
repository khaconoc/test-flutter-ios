import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'package:bccp_mobile_v2/data_service/repositories/receive/receive_repository.dart';
import 'package:get/get.dart';

import 'receive_package_crud_controller.dart';

class ReceivePackageCrudBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceivePackageCrudController>(() => ReceivePackageCrudController(
      receiveRepository: ReceiveRepository(),
      commonRepository: CommonRepository()
    ));
  }
}