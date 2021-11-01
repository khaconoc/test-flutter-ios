import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/position_service.dart';
import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'file:///D:/DATA/DHNI/source/bccp_mobile/lib/data_service/repositories/receive_special/receive_spec_repository.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../receive_spec_controller.dart';

class ReceiveSpecRequestDetailController extends GetxController {
  final ReceiveSpecRepository receiveSpecRepository;
  final CommonRepository commonRepository;
  ReceiveSpecController receiveController;
  PositionService positionService = Get.find();

  ReceiveSpecRequestDetailController(
      {this.receiveSpecRepository, this.commonRepository});

  var tabIndex = 0.obs;
  int requestId = Get.arguments['id'];
  final index = Get.arguments['index'];

  // final itemData = RequestAcceptedFindOneModel().obs;
  // final itemNumber = Rxn<int>();
  final itemNumberPostman = Rxn<int>();

  // final itemNumberSecret = Rxn<int>();
  final itemNumberSecretPostman = Rxn<int>();

  // final listPackageNormal = <RequestAcceptedDetail>[].obs;
  final isLoading = false.obs;
  final isSubmit = false.obs;

  final approvedDate = DateTime.now().obs;
  final senderCustomerCode = ''.obs;
  final senderCustomerError = ''.obs;
  final senderAddress = ''.obs;
  final senderTel = ''.obs;
  final senderObjectID = Rxn<String>();
  final approvedContent = ''.obs;
  final requestContent = ''.obs;
  final listPackage = [].obs;

  /// control bind error
  final approvedDateError = ''.obs;
  final senderCustomerCodeError = ''.obs;
  final senderAddressError = ''.obs;
  final senderTelError = ''.obs;
  final senderObjectIDError = ''.obs;
  final approvedContentError = ''.obs;
  final requestContentError = ''.obs;
  final itemNumberPostmanError = ''.obs;
  final itemNumberSecretPostmanError = ''.obs;

  final textButton = 'Xác nhận'.obs;
  final titleText = ''.obs;
  final action = ''.obs;
  final page = 1.obs;
  final count = 0.obs;
  final emptyData = false.obs;

  @override
  void onInit() async {
    initialController();
    findOneRequestAccepted();
    super.onInit();
  }

  initialController() {
    try {
      receiveController = Get.find();
    } catch (e) {}
  }

  pathValueInfo(Map value) {
    if (value['approvedDate'] != null) {
      approvedDate.value = DateTime.parse(value['approvedDate']);
    }
    // if (value['itemNumber'] != null) {
    //   itemNumber.value = value['itemNumber'];
    // }
    if (value['itemNumberPostman'] != null) {
      itemNumberPostman.value = value['itemNumberPostman'];
    }
    // if (value['itemNumberSecret'] != null) {
    //   itemNumberSecret.value = value['itemNumberSecret'];
    // }
    if (value['itemNumberSecretPostman'] != null) {
      itemNumberSecretPostman.value = value['itemNumberSecretPostman'];
    }
    if (value['senderCustomerCode'] != null) {
      senderCustomerCode.value = value['senderCustomerCode'];
    }
    if (value['senderAddress'] != null) {
      senderAddress.value = value['senderAddress'];
    }
    if (value['senderTel'] != null) {
      senderTel.value = value['senderTel'];
    }
    if (value['senderObjectID'] != null) {
      senderObjectID.value = value['senderObjectID'];
    }
    if (value['approvedContent'] != null) {
      approvedContent.value = value['approvedContent'];
    }
    if (value['requestContent'] != null) {
      requestContent.value = value['requestContent'];
    }
  }

  getValueInfo() {
    return {
      "approvedDate": approvedDate.value.toString(),
      // "itemNumber": itemNumber.value,
      "itemNumberPostman": itemNumberPostman.value,
      // "itemNumberSecret": itemNumberSecret.value,
      "itemNumberSecretPostman": itemNumberSecretPostman.value,
      "senderCustomerCode": senderCustomerCode.value,
      "senderAddress": senderAddress.value,
      "senderTel": senderTel.value,
      "senderObjectID": senderObjectID.value,
      "approvedContent": approvedContent.value,
      "requestContent": requestContent.value,
    };
  }

  onChangeCustomer(String value) async {
    senderCustomerCode.value = value;
    senderCustomerError.value = '';
    if (value.isEmpty) {
      senderAddress.value = '';
      return;
    }
    findOneCustomer(value);
  }

  findOneCustomer(String customer) async {
    var rs = await commonRepository.findOneCustomer(customer);
    if (rs.ok()) {
      senderAddress.value = rs.data.customerAddress;
      senderTel.value = rs.data.mobile;
    }
  }

  findOneRequestAccepted() async {
    isLoading.value = true;
    Map<String, dynamic> params = {
      "requestID": requestId
    };

    /// trường hợp tiếp nhận từ tuyến phát
    var deliveryData = Get.arguments['deliveryData'];
    if (deliveryData != null) {
      if (deliveryData['receiverAddress'] != null) {
        params['receiverAddress'] = deliveryData['receiverAddress'];
      }
      if (deliveryData['deliveryPointCode'] != null) {
        params['deliveryPointCode'] = deliveryData['deliveryPointCode'];
      }
      if (deliveryData['deliveryPointName'] != null) {
        params['deliveryPointName'] = deliveryData['deliveryPointName'];
      }
      if (deliveryData['customerCode'] != null) {
        params['customerCode'] = deliveryData['customerCode'];
      }
    }

    var rs = await receiveSpecRepository.findOneRequestAccepted(params);
    await 0.3.delay();
    isLoading.value = false;
    if (rs.ok()) {
      pathValueInfo(rs.data);
      requestId = rs.data['requestID'];
      textButton.value = rs.data['buttonText'];
      titleText.value = rs.data['titleText'];
      action.value = rs.data['action'].toString().toLowerCase();
    }
    if (requestId != null) {
      onLoadPagingItemList();
    }
  }

  onLoadPagingItemList({page = 1, size = kSize}) async {
    var params = {
      "page": page,
      "size": size,
      "loadMore": true,
      "requestID": requestId,
    };
    if (page == 1) {
      this.listPackage.clear();
      this.emptyData.value = false;
    }
    var rs = await receiveSpecRepository.getPagingItemList(params);
    if (rs.ok()) {
      this.page.value = page;
      var listOfData = rs.data['data'] as List;
      count.value = rs.data['paging']['count'];

      // if (listOfData.length < size + 1) {
      //   this.emptyData.value = true;
      // } else {
      //   listOfData.removeLast();
      // }
      if (rs.data['paging']['count'] < size + 1) {
        this.emptyData.value = true;
      }
      this.listPackage.addAll(listOfData);
    }
  }

  onLoadMorePackage() async {
    onLoadPagingItemList(page: this.page.value + 1);
  }

  /// function bind error
  bindError(Map error) {
    if (error['ApprovedDate'] != null) {
      approvedDateError.value = error['ApprovedDate'][0];
    }
    if (error['SenderCustomerCode'] != null) {
      senderCustomerCodeError.value = error['SenderCustomerCode'][0];
    }
    if (error['SenderAddress'] != null) {
      senderAddressError.value = error['SenderAddress'][0];
    }
    if (error['SenderTel'] != null) {
      senderTelError.value = error['SenderTel'][0];
    }
    if (error['SenderObjectID'] != null) {
      senderObjectIDError.value = error['SenderObjectID'][0];
    }
    if (error['ApprovedContent'] != null) {
      approvedContentError.value = error['ApprovedContent'][0];
    }
    if (error['RequestContent'] != null) {
      requestContentError.value = error['RequestContent'][0];
    }
    if (error['ItemNumberPostman'] != null) {
      itemNumberPostmanError.value = error['ItemNumberPostman'][0];
    }
    if (error['ItemNumberSecretPostman'] != null) {
      itemNumberSecretPostmanError.value = error['ItemNumberSecretPostman'][0];
    }
  }

  doPackageNormal(requestId, itemId, requestDetailId) async {
    if (requestId == null) {
      requestId = this.requestId;
    }
    var rs = await Get.toNamed(Routes.RECEIVE_SPEC_PACKAGE_CRUD, arguments: {
      'data': null,
      'index': index,
      'requestId': requestId,
      'itemId': itemId,
      'requestDetailId': requestDetailId,
    });
  }

  removePackageNormal(int index) {
    // listPackageNormal.removeAt(index);
  }

  bool validate() {
    int countErrors = 0;
    if (senderCustomerCode.value == null || senderCustomerCode.value == '') {
      senderCustomerError.value = 'Chưa chọn';
      countErrors++;
    }
    return countErrors < 1;
  }

  onUpdate() async {
    var confirm = await DialogService.confirm(message: textButton.value);
    if (!confirm) return;

    // if (!validate()) {
    //   DialogService.alert(message: 'Vui lòng điền đủ thông tin');
    //   return;
    // }
    isSubmit.value = true;

    /// lấy vị trí
    Position position;
    try {
      position = await positionService.getPosition();
    } catch (e) {
      DialogService.alert(message: 'Không lấy được vị trí');
      isSubmit.value = false;
      return;
    }

    var formData = getValueInfo();
    formData['requestID'] = requestId;
    formData['lat'] = position.latitude;
    formData['long'] = position.longitude;
    var rs = await receiveSpecRepository.capNhatyeuCau(formData);
    isSubmit.value = false;
    if (rs.ok()) {
      if (receiveController != null)
        receiveController.listViewPagingKey.currentState.getData();
      await DialogService.alert(message: 'Cập nhật thành công');
      Get.back();
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
