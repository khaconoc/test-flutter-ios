import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'file:///D:/DATA/DHNI/source/bccp_mobile/lib/data_service/repositories/receive_special/receive_spec_repository.dart';
import 'package:get/get.dart';

import 'receive_spec_package_crud_controller.dart';

class ReceiveSpecPackageCrudBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiveSpecPackageCrudController>(() => ReceiveSpecPackageCrudController(
      receiveSpecRepository: ReceiveSpecRepository(),
      commonRepository: CommonRepository()
    ));
  }
}