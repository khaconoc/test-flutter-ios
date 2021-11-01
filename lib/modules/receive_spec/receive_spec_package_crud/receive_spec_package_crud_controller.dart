import 'dart:convert';

import 'package:bccp_mobile_v2/core/services/auth_service.dart';
import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/data_service/models/co_quan_nhan_tuyen_phat_findone_model.dart';
import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'file:///D:/DATA/DHNI/source/bccp_mobile/lib/data_service/repositories/receive_special/receive_spec_repository.dart';
import 'package:bccp_mobile_v2/modules/receive_spec/receive_spec_request_detail/receive_spec_request_detail_controller.dart';
import 'package:get/get.dart';

class ReceiveSpecPackageCrudController extends GetxController {
  ReceiveSpecRequestDetailController receiveSpecRequestDetailController = Get.find();
  final ReceiveSpecRepository receiveSpecRepository;
  final CommonRepository commonRepository;

  ReceiveSpecPackageCrudController({this.receiveSpecRepository, this.commonRepository});

  final requestId = Get.arguments['requestId'];
  final itemId = Get.arguments['itemId'];
  final requestDetailId = Get.arguments['requestDetailId'];

  final action = ''.obs;

  final itemID = ''.obs;

  final itemCode = ''.obs;

  /// số công văn
  final itemCodeCustomer = ''.obs;

  /// loại bưu gửi
  final itemTypeCode = Rxn<String>('HT');

  /// giờ hẹn
  final timerDelivery = Rxn<DateTime>();

  /// ngày giờ phát
  // final sendingTime = Rxn<DateTime>();

  /// cân nặng
  final weight = Rxn<int>();

  /// Họ tên người nhận / Phòng ban, đơn vị
  final receiverFullName = ''.obs;

  final coQuanNhan = CoQuanNhanTuyenPhatFindOneModel().obs;

  /// cơ quan nhận
  final receiverCustomerCode = Rxn<String>();

  /// Điểm phát
  final deliveryPointCode = Rxn<String>();

  /// cơ quan nhận/ điểm phát khác
  // final deliveryPointName = Rxn<String>();

  /// Đối tượng nhận --- chưa có

  /// địa chỉ - receiverCustomerAddress
  final receiverAddress = ''.obs;

  /// điện thoại  -- receiverTel
  final receiverTel = ''.obs;

  /// Dịch vụ GTGT
  // final vas = [].obs;

  final receiverProvinceCode = Rxn<String>();
  final receiverDistrictCode = Rxn<String>();
  final receiverCommuneCode = Rxn<String>();

  /// Ngày giờ phát
  /// Họ tên người thực nhận
  /// Lý do không phát được
  /// Ghi chú
  final note = ''.obs;

  final attachFile = <dynamic>[].obs;
  final imageListError = ''.obs;

  /// lý do cập nhật
  // final reasonModified = ''.obs;
  // final reasonModifiedError = ''.obs;
  /// control bind error
  final itemCodeError = ''.obs;
  final itemCodeCustomerError = ''.obs;
  final itemTypeCodeError = ''.obs;
  final timerDeliveryError = ''.obs;
  final weightError = ''.obs;
  final receiverFullNameError = ''.obs;
  final receiverCustomerCodeError = ''.obs;
  final deliveryPointCodeError = ''.obs;
  final receiverAddressError = ''.obs;
  final receiverTelError = ''.obs;
  final receiverProvinceCodeError = ''.obs;
  final receiverDistrictCodeError = ''.obs;
  final receiverCommuneCodeError = ''.obs;
  final noteError = ''.obs;
  final attachFileError = ''.obs;

  final buttonText = ''.obs;

  Map itemData = {};

  Map<String, bool> listHenGio = {
    'HTG': true,
    'HG': true,
    'TGA': true,
    'TGB': true,
    'TGC': true,
    'HGA': true,
    'HGB': true,
    'HGC': true,
  };

  @override
  void onInit() async {
    super.onInit();
    khoiTao();
  }

  /// function bind error
  bindError(Map error) {
    if (error['ItemCode'] != null) {
      itemCodeError.value = error['ItemCode'][0];
    }
    if (error['ItemCodeCustomer'] != null) {
      itemCodeCustomerError.value = error['ItemCodeCustomer'][0];
    }
    if (error['ItemTypeCode'] != null) {
      itemTypeCodeError.value = error['ItemTypeCode'][0];
    }
    if (error['TimerDelivery'] != null) {
      timerDeliveryError.value = error['TimerDelivery'][0];
    }
    if (error['Weight'] != null) {
      weightError.value = error['Weight'][0];
    }
    if (error['ReceiverFullName'] != null) {
      receiverFullNameError.value = error['ReceiverFullName'][0];
    }
    if (error['ReceiverCustomerCode'] != null) {
      receiverCustomerCode.value = error['ReceiverCustomerCode'][0];
    }
    if (error['DeliveryPointCode'] != null) {
      deliveryPointCodeError.value = error['DeliveryPointCode'][0];
    }
    if (error['ReceiverAddress'] != null) {
      receiverAddressError.value = error['ReceiverAddress'][0];
    }
    if (error['ReceiverTel'] != null) {
      receiverTelError.value = error['ReceiverTel'][0];
    }
    if (error['ReceiverProvinceCode'] != null) {
      receiverProvinceCodeError.value = error['ReceiverProvinceCode'][0];
    }
    if (error['ReceiverDistrictCode'] != null) {
      receiverDistrictCodeError.value = error['ReceiverDistrictCode'][0];
    }
    if (error['ReceiverCommuneCode'] != null) {
      receiverCommuneCodeError.value = error['ReceiverCommuneCode'][0];
    }
    if (error['Note'] != null) {
      noteError.value = error['Note'][0];
    }
    if (error['AttachFile'] != null) {
      attachFileError.value = error['AttachFile'][0];
    }
  }

  onSelectProvince(String value) {
    this.receiverProvinceCode.value = value;
    if(value.isEmpty) {
      this.receiverDistrictCode.value = null;
      this.receiverCommuneCode.value = null;
    }
  }

  onSelectDistrict(String value) {
    this.receiverDistrictCode.value = value;
    if(value.isEmpty) {
      this.receiverCommuneCode.value = null;
    }
  }

  void khoiTao() async {
    var params = {
      "requestID": requestId,
      "requestDetailID": requestDetailId,
      "itemID": itemId
    };
    var rs = await receiveSpecRepository.findOneBuuGui(params);
    if(rs.ok()) {
      pathValueInfo(rs.data);
      itemData = rs.data;
      buttonText.value = rs.data['buttonText'];
    } else {
      await DialogService.error(message: rs.getMsgError());
      Get.back();
    }
  }

  pathValueInfo(Map value) {
    if (value['itemCode'] != null) {
      itemCode.value = value['itemCode'];
    }
    if (value['action'] != null) {
      action.value = value['action'].toString().toLowerCase();
    }
    if (value['itemCodeCustomer'] != null) {
      itemCodeCustomer.value = value['itemCodeCustomer'];
    }
    if (value['itemTypeCode'] != null) {
      itemTypeCode.value = value['itemTypeCode'];
    }
    if (value['timerDelivery'] != null) {
      timerDelivery.value = DateTime.parse(value['timerDelivery']);
    }
    // if (value['sendingTime'] != null) {
    //   sendingTime.value = DateTime.parse(value['sendingTime']);
    // }
    if (value['weight'] != null) {
      weight.value = value['weight'];
    }
    if (value['receiverFullName'] != null) {
      receiverFullName.value = value['receiverFullName'];
    }
    if (value['receiverCustomerCode'] != null) {
      receiverCustomerCode.value = value['receiverCustomerCode'];
    }
    if (value['deliveryPointCode'] != null) {
      deliveryPointCode.value = value['deliveryPointCode'];
    }
    // if (value['deliveryPointName'] != null) {
    //   deliveryPointName.value = value['deliveryPointName'];
    // }
    if (value['receiverAddress'] != null) {
      receiverAddress.value = value['receiverAddress'];
    }
    // if (value['reasonModified'] != null) {
    //   reasonModified.value = value['reasonModified'];
    // }
    if (value['receiverTel'] != null) {
      receiverTel.value = value['receiverTel'];
    }
    // if (value['vas'] != null) {
    //   vas.value = json.decode(value['vas']);
    // }
    if (value['receiverProvinceCode'] != null) {
      receiverProvinceCode.value = value['receiverProvinceCode'];
    }
    if (value['receiverDistrictCode'] != null) {
      receiverDistrictCode.value = value['receiverDistrictCode'];
    }
    if (value['receiverCommuneCode'] != null) {
      receiverCommuneCode.value = value['receiverCommuneCode'];
    }
    if (value['note'] != null) {
      note.value = value['note'];
    }
    if (value['attachFile'] != null) {
      attachFile.value = json.decode(value['attachFile']);
    }
  }

  getValueInfo() {
    return {
      "itemCodeCustomer": itemCodeCustomer.value,
      "itemTypeCode": itemTypeCode.value,
      "timerDelivery": timerDelivery.value == null ? null : timerDelivery.value.toString(),
      // "sendingTime": sendingTime.value == null ? null : sendingTime.value.toString(),
      "weight": weight.value,
      "receiverFullName": receiverFullName.value,
      "receiverCustomerCode": receiverCustomerCode.value,
      "deliveryPointCode": deliveryPointCode.value,
      // "deliveryPointName": deliveryPointName.value,
      "receiverAddress": receiverAddress.value,
      // "reasonModified": reasonModified.value,
      "receiverTel": receiverTel.value,
      // "vas": vas.value,
      "receiverProvinceCode": receiverProvinceCode.value,
      "receiverDistrictCode": receiverDistrictCode.value,
      "receiverCommuneCode": receiverCommuneCode.value,
      "note": note.value,
      "attachFile": json.encode(attachFile.value),
    };
  }

  onChangeItemType(String value) {
    // if (listHenGio[value] != null && listHenGio[value]) {
    //   print('hen gio');
    // }
  }

  onSelectCoQuanNhan(String value) async {
    if (value != null && value != '') {
      var rs = await commonRepository.getFristDiemPhatByCoQuanNhan(value);
      if (rs.ok()) {
        deliveryPointCode.value = rs.data;
        onSelectDiemPhat(rs.data);
      }
    } else {
      deliveryPointCode.value = null;
      receiverAddress.value = '';
      receiverProvinceCode.value = null;
      receiverDistrictCode.value = null;
      receiverCommuneCode.value = null;
    }
  }

  onSelectDiemPhat(String value) async {
    if (value.isEmpty) {
      return;
    }
    // deliveryPointNameText.value = '';
    Map<String, dynamic> params = {
      "where": {
        "and": [
          {"deliveryPointCode": value}
        ]
      }
    };
    var rs = await commonRepository.findOneTuyenPhat(params);
    if (rs.ok()) {
      receiverAddress.value = rs.data.deliveryPointAddress;
      coQuanNhan.value = rs.data;

      receiverProvinceCode.value = rs.data.provinceCode;
      receiverDistrictCode.value = rs.data.districtCode;
      receiverCommuneCode.value = rs.data.communeCode;
    }
  }

  setImageList(List list) {
    attachFile.value = List.from(list);
    imageListError.value = '';
  }

  doPackage() async {
    if(attachFile.value.length < 1) {
      var rs = await DialogService.confirm(message: 'Bưu gửi này chưa gắn ảnh! Bạn vẫn muốn tiếp tục thêm không');
      if (!rs) {
        return;
      }
    }
    Map<String, dynamic> params = Map.from(itemData);
    var formData = getValueInfo();
    params = {
      ...params,
      ...formData,
    };
    var rs = await receiveSpecRepository.capNhatBuuGui(params);
    if(rs.ok()) {
      receiveSpecRequestDetailController.onLoadPagingItemList();
      await DialogService.alert(message: 'Ghi thành công');
      Get.back();
    } else {
      bindError(rs.getErrorObject());
      DialogService.error(message: rs.getMsgError());
    }
  }

  bool validate() {
    int countError = 0;
    if(itemCodeCustomer.value == null || itemCodeCustomer.value == '') {
      countError++;
      itemCodeCustomerError.value = 'Chưa chọn';
    }
    if(receiverFullName.value == null || receiverFullName.value == '') {
      countError++;
      receiverFullNameError.value = 'Chưa chọn';
    }
    // if(itemTypeCode.value == null || itemTypeCode.value == '') {
    //   countError++;
    //   itemTypeCodeError.value = 'Chưa chọn';
    // }
    if(receiverAddress.value == null || receiverAddress.value == '') {
      countError++;
      receiverAddressError.value = 'Chưa chọn';
    }
    // if(action.value == 'edit' && (reasonModified.value == null || reasonModified.value == '')) {
    //   countError++;
    //   reasonModifiedError.value = 'Không được trống';
    // }
    return countError < 1;
  }

  removePackage() async {
    var confirm =
        await DialogService.confirm(message: 'Xác nhận xóa bưu gửi này');
    if (!confirm) return;
    var params = {
      "requestID": requestId,
      "requestDetailID": requestDetailId,
      "itemID": itemId
    };
    var rs = await receiveSpecRepository.deleteBuuGui(params);
    if(rs.ok()) {
      await DialogService.alert(message: 'Xóa thành công');
      Get.back();
    } else {
      DialogService.error(message: rs.getMsgError());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
