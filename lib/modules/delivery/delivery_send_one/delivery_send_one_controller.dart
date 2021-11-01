import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/position_service.dart';
import 'package:bccp_mobile_v2/core/services/utils_service.dart';
import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'package:bccp_mobile_v2/data_service/repositories/delivery/delivery_repository.dart';
import 'package:bccp_mobile_v2/modules/delivery/delivery_detail/delivery_detail_controller.dart';
import 'package:bccp_mobile_v2/modules/search/search_controller.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class DeliverySendOneController extends GetxController {
  DeliverRepository deliverRepository;
  CommonRepository commonRepository;

  PositionService positionService = Get.find();
  UtilsService _utilsService = Get.find();
  DeliveryDetailController deliveryDetailController;
  SearchController searchController;

  DeliverySendOneController({this.deliverRepository, this.commonRepository});

  final itemCode = ''.obs;

  final senderCustomerName = ''.obs;
  final senderCustomerAddress = ''.obs;
  final deliveryPointName = ''.obs;
  final receiverCustomerAddress = ''.obs;
  final realReciverName = ''.obs;

  final isHaveDeliveryPoint = true.obs;

  /// form control
  final isDeliverable = true.obs;
  final retry = Rxn<bool>();

  final deliveryDate = Rxn<DateTime>();
  final deliveryPointReceiver = Rxn<Map>();
  final nguoiThucNhanFullInfo = Rxn<Map>();
  final deliveryNote = ''.obs;
  final causeCode = Rxn<String>();
  final attachFile = [].obs;

  final itemData = {}.obs;

  final buttonText = ''.obs;
  final action = ''.obs;
  final isLoading = false.obs;

  final isSubmit = false.obs;

  /// control bind error
  final deliveryDateError = ''.obs;
  final deliveryPointReceiverError = ''.obs;
  final deliveryNoteError = ''.obs;
  final causeCodeError = ''.obs;
  final attachFileError = ''.obs;
  final realReciverNameError = ''.obs;
  final callHistory = [].obs;

  /// thong tin chứng từ chuyển trả
  final isAr = false.obs;

  final createDateR = Rxn<DateTime>();
  final itemCodeR = ''.obs;
  final receiverNameR = ''.obs;
  final posCodeOringinR = Rxn<String>();
  final typeR = Rxn<String>('1');
  final posCodeNewR = Rxn<String>();
  final receiverAddressR = ''.obs;
  final provinceR = Rxn<String>();
  final districtR = Rxn<String>();
  final communeR = Rxn<String>();
  final receiverMobileR = ''.obs;
  final receiverEmailR = ''.obs;

  final createDateRError = ''.obs;
  final itemCodeRError = ''.obs;
  final receiverNameRError = ''.obs;
  final pOSCodeOringinRError = ''.obs;
  final typeRError = ''.obs;
  final pOSCodeNewRError = ''.obs;
  final receiverAddressRError = ''.obs;
  final provinceRError = ''.obs;
  final districtRError = ''.obs;
  final communeRError = ''.obs;
  final receiverMobileRError = ''.obs;
  final receiverEmailRError = ''.obs;

  /// function bind error
  bindError(Map error) {
    if (error['DeliveryDate'] != null) {
      deliveryDateError.value = error['DeliveryDate'][0];
    }
    if (error['DeliveryPointReceiver'] != null) {
      deliveryPointReceiverError.value = error['DeliveryPointReceiver'][0];
    }
    if (error['DeliveryNote'] != null) {
      deliveryNoteError.value = error['DeliveryNote'][0];
    }
    if (error['CauseCode'] != null) {
      causeCodeError.value = error['CauseCode'][0];
    }
    if (error['AttachFile'] != null) {
      attachFileError.value = error['AttachFile'][0];
    }
    if (error['RealReciverName'] != null) {
      realReciverNameError.value = error['RealReciverName'][0];
    }
  }

  @override
  void onInit() async {
    super.onInit();
    getData();
    loadController();
  }

  onSelectProvince(String value) {
    if(value.isEmpty || this.provinceR.value != value) {
      this.districtR.value = null;
      this.communeR.value = null;
    }
    this.provinceR.value = value;
  }

  onSelectDistrict(String value) {
    if(value.isEmpty || this.districtR.value != value) {
      this.communeR.value = null;
    }
    this.districtR.value = value;
  }

  loadController() {
    try {
      deliveryDetailController = Get.find();
    } catch (e) {}
    try {
      searchController = Get.find();
    } catch (e) {}
  }

  getData() async {
    Map data = Get.arguments;
    Map<String, dynamic> params = {
      'id': data['id'],
      'itemID': data['itemID'],
      'mailtripID': data['mailtripID'],
    };
    isLoading.value = true;
    var rs = await deliverRepository.findOneBuuGuiOne(body: params);
    await 0.3.delay();
    isLoading.value = false;
    if (rs.ok()) {
      itemData.value = rs.data;
      pathValueForm(rs.data);
      if (rs.data['realReciverName'] != null) {
        isHaveDeliveryPoint.value = false;
      }
      if(rs.data['deliveryPointReceiver'] != null) {
        findOneNguoiThucNhan({
          'deliveryPointReceiverCode': rs.data['deliveryPointReceiver']['deliveryPointReceiverCode']
        });
      }
    } else {
      DialogService.error(message: rs.getMsgError());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void openMap() {}

  void setImageList(List list) {
    attachFile.value = List.from(list);
    // imageListError.value = '';
  }

  void onAddDelivery() async {
    // if (deliveryPointReceiver.value == null ||
    //     deliveryPointReceiver.value.length < 1) {
    //   DialogService.alert(message: 'Chưa chọn người thực nhận');
    //   return;
    // }
    // showModalBottomSheet(
    //   context: Get.overlayContext,
    //   builder: (BuildContext bc) {
    //     return Container(
    //       child: new Wrap(
    //         children: <Widget>[
    //           new ListTile(
    //             title: new Text(
    //                 'Gọi: ${nguoiThucNhanFullInfo.value['receiverFullName']}'),
    //             subtitle:
    //                 new Text('${nguoiThucNhanFullInfo.value['receiverPhone']}'),
    //             onTap: () {
    //               launch(
    //                   "tel: ${nguoiThucNhanFullInfo.value['receiverPhone']}");
    //               // imageSelector(context, "gallery"),
    //               // Navigator.pop(context),
    //             },
    //           ),
    //           Divider(),
    //           new ListTile(
    //             title: new Text('Sao chép'),
    //             onTap: () {
    //               Clipboard.setData(ClipboardData(
    //                   text: nguoiThucNhanFullInfo.value['receiverPhone']));
    //               Get.back();
    //               DialogService.showSnackBar(
    //                   'Đã sao chép', StatusSnackBar.success);
    //             },
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
    // launch("tel: 0962290476");
    var id = await Get.toNamed(Routes.RECEIVER_REAL_ADD, arguments: {
      'deliveryPointCode': itemData['deliveryPointCode'],
      'customerCode': itemData['receiverCustomerCode']
    });
    if (id != null) {
      deliveryPointReceiver.value = id;
    }
  }

  void onCall() async {
    if (deliveryPointReceiver.value == null ||
        deliveryPointReceiver.value.length < 1) {
      DialogService.alert(message: 'Chưa chọn người thực nhận');
      return;
    }
    showModalBottomSheet(
      context: Get.overlayContext,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                title: new Text(
                    'Gọi: ${nguoiThucNhanFullInfo.value['receiverFullName']??''}'),
                subtitle:
                    new Text('${nguoiThucNhanFullInfo.value['receiverPhone']??''}'),
                onTap: () {
                  launch(
                      "tel: ${nguoiThucNhanFullInfo.value['receiverPhone']}");
                  createHisCall(
                      itemId: itemData['itemID'],
                      name: nguoiThucNhanFullInfo.value['receiverFullName'],
                      phone: nguoiThucNhanFullInfo.value['receiverPhone']);
                  // imageSelector(context, "gallery"),
                  // Navigator.pop(context),
                },
              ),
              Divider(),
              new ListTile(
                title: new Text('Sao chép'),
                onTap: () {
                  Clipboard.setData(ClipboardData(
                      text: nguoiThucNhanFullInfo.value['receiverPhone']));
                  Get.back();
                  DialogService.showSnackBar(
                      'Đã sao chép', StatusSnackBar.success);
                },
              ),
            ],
          ),
        );
      },
    );
    // launch("tel: 0962290476");
  }

  Future<void> createHisCall(
      {String name, String phone, dynamic itemId}) async {
    Map<String, dynamic> params = {
      'phone': phone,
      'name': name,
      'itemId': itemId
    };
    // var rs = await commonRepository.createCall(params);
    callHistory.add(params);
  }

  void findOneNguoiThucNhan(param) async {
    if (param == null) {
      nguoiThucNhanFullInfo.value = null;
      return;
    }
    var rs = await commonRepository
        .findOneDeliveryPointReceive(param['deliveryPointReceiverCode']);
    if (rs.ok()) {
      nguoiThucNhanFullInfo.value = rs.data;
    }
  }

  pathValueForm(Map value) {
    if (value['itemCode'] != null) {
      itemCode.value = value['itemCode'];
    }
    if (value['senderCustomerName'] != null) {
      senderCustomerName.value = value['senderCustomerName'];
    }
    if (value['senderCustomerAddress'] != null) {
      senderCustomerAddress.value = value['senderCustomerAddress'];
    }
    if (value['deliveryPointName'] != null) {
      deliveryPointName.value = value['deliveryPointName'];
    }
    if (value['receiverCustomerAddress'] != null) {
      receiverCustomerAddress.value = value['receiverCustomerAddress'];
    }
    if (value['isDeliverable'] != null) {
      isDeliverable.value = value['isDeliverable'];
    }
    if (value['deliveryDate'] != null) {
      deliveryDate.value = DateTime.parse(value['deliveryDate']);
    }
    if (value['deliveryPointReceiver'] != null) {
      deliveryPointReceiver.value = value['deliveryPointReceiver'];
    }
    if (value['deliveryNote'] != null) {
      deliveryNote.value = value['deliveryNote'];
    }
    if (value['causeCode'] != null) {
      causeCode.value = value['causeCode'];
    }
    if (value['retry'] != null) {
      retry.value = value['retry'];
    }
    if (value['attachFile'] != null) {
      attachFile.value = json.decode(value['attachFile']);
    }
    if (value['buttonText'] != null) {
      buttonText.value = value['buttonText'];
    }
    if (value['action'] != null) {
      action.value = value['action'].toString().toUpperCase();
    }
    if (value['realReciverName'] != null) {
      realReciverName.value = value['realReciverName'];
    }
    if (value['callHistory'] != null) {
      callHistory.value = (value['callHistory']);
    }
    if (value['isAr'] != null) {
      isAr.value = value['isAr'];
    }
    if (value['arData'] != null) {

      var arData = value['arData'];

      if (arData['createDate'] != null) {
        createDateR.value = DateTime.parse(arData['createDate']);
      }
      if (arData['itemCode'] != null) {
        itemCodeR.value = arData['itemCode'];
      }
      if (arData['receiverName'] != null) {
        receiverNameR.value = arData['receiverName'];
      }
      if (arData['posCodeOringin'] != null) {
        posCodeOringinR.value = arData['posCodeOringin'];
      }
      if (arData['posCodeNew'] != null) {
        posCodeNewR.value = arData['posCodeNew'];
      }
      if (arData['typeR'] != null) {
        typeR.value = arData['typeR'];
      }
      if (arData['receiverAddress'] != null) {
        receiverAddressR.value = arData['receiverAddress'];
      }
      if (arData['province'] != null) {
        provinceR.value = arData['province'];
      }
      if (arData['district'] != null) {
        districtR.value = arData['district'];
      }
      if (arData['commune'] != null) {
        communeR.value = arData['commune'];
      }
      if (arData['receiverMobile'] != null) {
        receiverMobileR.value = arData['receiverMobile'];
      }
      if (arData['receiverEmail'] != null) {
        receiverEmailR.value = arData['receiverEmail'];
      }
    }
  }

  getValueForm() {
    return {
      "isDeliverable": isDeliverable.value,
      "deliveryDate":
          deliveryDate.value != null ? deliveryDate.value.toString() : null,
      "deliveryPointReceiver": deliveryPointReceiver.value,
      "deliveryNote": deliveryNote.value,
      "causeCode": causeCode.value,
      "retry": retry.value,
      "attachFile":
          attachFile.length > 0 ? json.encode(attachFile.value) : null,
      "realReciverName": realReciverName.value,
      "callHistory": callHistory.value,
      /// thong tin chung tu chuyen tra
      "arData": {
        "createDate": createDateR.value != null ? createDateR.value.toString() : null,
        // "createDate": createDateR.value,
        "itemCode": itemCodeR.value,
        "receiverName": receiverNameR.value,
        "posCodeOringin": posCodeOringinR.value,
        "posCodeNew": posCodeNewR.value,
        "type": typeR.value,
        "receiverAddress": receiverAddressR.value,
        "province": provinceR.value,
        "district": districtR.value,
        "commune": communeR.value,
        "receiverMobile": receiverMobileR.value,
        "receiverEmail": receiverEmailR.value
      },
    };
  }

  void onPhat() async {
    var confirm = await DialogService.confirm(message: buttonText.value);
    if (!confirm) return;

    // if (deliveryPointReceiver.value == null ||
    //     deliveryPointReceiver.value.length < 1) {
    //   DialogService.alert(message: 'Chưa chọn người thực nhận');
    //   return;
    // }

    /// lấy vị trí
    isSubmit.value = true;
    Position position;
    try {
      position = await positionService.getPosition();
    } catch (e) {
      DialogService.alert(message: 'Không lấy được vị trí');
      isSubmit.value = false;
      return;
    }

    Map params = getValueForm();
    params['id'] = itemData['id'];
    params['itemID'] = itemData['itemID'];
    params['mailtripID'] = itemData['mailtripID'];
    params['lat'] = position.latitude;
    params['long'] = position.longitude;
    var rs = await deliverRepository.onPhatOne(params);
    isSubmit.value = false;
    if (rs.ok()) {
      if (deliveryDetailController != null) {
        deliveryDetailController.listViewPagingKey.currentState.getData();
      }
      if (searchController != null) {
        searchController.listViewPagingKey.currentState.getData();
      }
      await DialogService.alert(message: '${buttonText.value} thành công');
      Get.back();
    } else {
      bindError(rs.getErrorObject());
      DialogService.error(message: rs.getMsgError());
    }
  }

  void scanCode() async {
    var code = await _utilsService.scanCode();
    if (code.isNotEmpty) {
      itemCodeR.value = code;
    }
  }
}
