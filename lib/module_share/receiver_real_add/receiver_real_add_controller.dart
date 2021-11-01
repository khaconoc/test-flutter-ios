import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'package:get/get.dart';
import 'dart:convert';

class ReceiverRealAddController extends GetxController {
  CommonRepository commonRepository;

  ReceiverRealAddController({this.commonRepository});

  // final deliveryPointCode = ''.obs;
  // final customerCode = ''.obs;
  final receiverFullName = ''.obs;
  final receiverPhone = ''.obs;
  final receiverDepartment = ''.obs;
  final receiverPosition = ''.obs;

  /// control bind error
  // final deliveryPointCodeError = ''.obs;
  // final customerCodeError = ''.obs;
  final receiverFullNameError = ''.obs;
  final receiverPhoneError = ''.obs;
  final receiverDepartmentError = ''.obs;
  final receiverPositionError = ''.obs;

  final isSubmit = false.obs;

  final dataRoute = Get.arguments;
  /// function bind error
  bindError(Map error) {
    // if (error['DeliveryPointCode'] != null) {
    //   deliveryPointCodeError.value = error['DeliveryPointCode'][0];
    // }
    // if (error['CustomerCode'] != null) {
    //   customerCodeError.value = error['CustomerCode'][0];
    // }
    if (error['ReceiverFullName'] != null) {
      receiverFullNameError.value = error['ReceiverFullName'][0];
    }
    if (error['ReceiverPhone'] != null) {
      receiverPhoneError.value = error['ReceiverPhone'][0];
    }
    if (error['ReceiverDepartment'] != null) {
      receiverDepartmentError.value = error['ReceiverDepartment'][0];
    }
    if (error['ReceiverPosition'] != null) {
      receiverPositionError.value = error['ReceiverPosition'][0];
    }
  }

  getValue() {
    return {
      // 'deliveryPointCode': deliveryPointCode.value,
      // 'customerCode': customerCode.value,
      'receiverFullName': receiverFullName.value,
      'receiverPhone': receiverPhone.value,
      'receiverDepartment': receiverDepartment.value,
      'receiverPosition': receiverPosition.value,
    };
  }

  @override
  void onInit() async {
    super.onInit();
  }

  onSubmit() async {
    Map<String, dynamic> params = getValue();
    params = {
      ...params,
      ...dataRoute
    };
    // return;
    isSubmit.value = true;
    var rs = await commonRepository.createDeliveryPointReceive(params);
    isSubmit.value = false;
    if (rs.ok()) {
      await DialogService.alert(message: 'Đã thêm');
      Get.back(result: rs.data);
    } else {
      bindError(rs.getErrorObject());
      DialogService.error(message: rs.getMsgError());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
