import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/position_service.dart';
import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'package:bccp_mobile_v2/data_service/repositories/delivery/delivery_repository.dart';
import 'package:bccp_mobile_v2/data_service/repositories/delivery_special/delivery_spec_repository.dart';
import 'package:bccp_mobile_v2/modules/search/search_controller.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

import '../delivery_spec_controller.dart';

class DeliverySpecSendOneController extends GetxController {
  DeliverySpecRepository deliverSpecRepository;
  CommonRepository commonRepository;

  PositionService positionService = Get.find();
  DeliverySpecController deliverySpecController;
  SearchController searchController;

  DeliverySpecSendOneController(
      {this.deliverSpecRepository, this.commonRepository});

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
  final isLoading = false.obs;

  final buttonText = ''.obs;
  final action = ''.obs;
  final isSubmit = false.obs;

  /// control bind error
  final deliveryDateError = ''.obs;
  final deliveryPointReceiverError = ''.obs;
  final deliveryNoteError = ''.obs;
  final causeCodeError = ''.obs;
  final attachFileError = ''.obs;
  final realReciverNameError = ''.obs;
  final callHistory = [].obs;




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

  loadController() {
    try {
      deliverySpecController = Get.find();
    } catch (e) {

    }
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
    var rs = await deliverSpecRepository.findOneBuuGuiOne(body: params);
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
                    'Gọi: ${nguoiThucNhanFullInfo.value['receiverFullName']}'),
                subtitle:
                    new Text('${nguoiThucNhanFullInfo.value['receiverPhone']}'),
                onTap: () async {
                  var rsCall = await launch(
                      "tel: ${nguoiThucNhanFullInfo.value['receiverPhone']}");
                  createHisCall(
                    itemId: itemData['itemID'],
                    name: nguoiThucNhanFullInfo.value['receiverFullName'],
                    phone: nguoiThucNhanFullInfo.value['receiverPhone']
                  );
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
    // Map<String, dynamic> params = {
    //   'phone': phone,
    //   'name': name,
    //   'itemId': itemId
    // };
    // var rs = await commonRepository.createCall(params);
    callHistory.add({
      'phone': phone,
      'name': name
    });
  }

  Future<void> onAddDelivery() async {
    var id = await Get.toNamed(Routes.RECEIVER_REAL_ADD, arguments: {
      'deliveryPointCode': itemData['deliveryPointCode'],
      'customerCode': itemData['receiverCustomerCode']
    });
    if (id != null) {
      deliveryPointReceiver.value = id;
    }
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
      callHistory.value = value['callHistory'];
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

    var rs = await deliverSpecRepository.onPhatOne(params);
    isSubmit.value = false;
    if (rs.ok()) {
      if (deliverySpecController != null) {
        deliverySpecController.listViewPagingKey.currentState.getData();
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
}
