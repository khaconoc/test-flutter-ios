import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/position_service.dart';
import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'package:bccp_mobile_v2/data_service/repositories/delivery/delivery_repository.dart';
import 'package:bccp_mobile_v2/modules/delivery/delivery_detail/delivery_detail_controller.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class DeliverySendMoreController extends GetxController {
  DeliverRepository deliverRepository;
  CommonRepository commonRepository;

  PositionService positionService = Get.find();
  DeliveryDetailController deliveryDetailController = Get.find();

  DeliverySendMoreController({this.deliverRepository, this.commonRepository});

  final senderCustomerName = ''.obs;
  final senderCustomerAddress = ''.obs;
  final deliveryPointName = ''.obs;
  final receiverCustomerAddress = ''.obs;
  final realReciverName = ''.obs;

  final isHaveDeliveryPoint = true.obs;

  /// form control
  final isDeliverable = true.obs;
  final deliveryDate = Rxn<DateTime>();
  final deliveryPointReceiver = Rxn<Map>();
  final nguoiThucNhanFullInfo = Rxn<Map>();
  final deliveryNote = ''.obs;
  final causeCode = Rxn<String>();
  final attachFile = [].obs;

  final itemData = {}.obs;

  final buttonText = ''.obs;

  final listPackage = [].obs;
  final page = 1.obs;
  final count = 0.obs;
  final emptyData = false.obs;
  final isLoadingItemPaging = false.obs;

  final listPackageIgnore = <dynamic>{}.obs;

  final titlePage = ''.obs;
  final isLoading = false.obs;

  Map dataRoute = Get.arguments;

  final isSubmit = false.obs;

  /// control bind error
  final deliveryDateError = ''.obs;
  final deliveryPointReceiverError = ''.obs;
  final deliveryNoteError = ''.obs;
  final causeCodeError = ''.obs;
  final attachFileError = ''.obs;
  final realReciverNameError = ''.obs;
  final callHistory = [].obs;

  Position position;

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
    titlePage.value = dataRoute['deliveryPointName'];
    isLoading.value = true;
    await loadLocation();
    getData();
    onLoadPagingItemList();
  }

  loadLocation() async {
    try {
      position = await positionService.getPosition();
    } catch (e) {}
  }

  getData() async {
    Map<String, dynamic> params = {
      'mailtripID': dataRoute['mailtripID'],
      // "customerCode": dataRoute['customerCode'],
      "deliveryPointName": dataRoute['deliveryPointName'],
      "deliveryPointCode": dataRoute['deliveryPointCode'],
      "customerCode": dataRoute['customerCode'],
      "receiverAddress": dataRoute['receiverAddress'],
    };
    var rs = await deliverRepository.findOneBuuGuiMore(body: params);
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
    isLoading.value = false;
  }

  onLoadPagingItemList({page = 1, size = kSize}) async {
    var params = {
      "page": page,
      "size": size,
      "loadMore": true,
      'lat': position.latitude,
      'long': position.longitude,
      "mailtripID": dataRoute["mailtripID"],
      "receiverAddress": dataRoute["receiverAddress"],
      "deliveryPointCode": dataRoute["deliveryPointCode"],
      "deliveryPointName": dataRoute["deliveryPointName"],
      // "customerCode": dataRoute["customerCode"],
      "status": 0
    };
    if (page == 1) {
      this.listPackage.clear();
      this.emptyData.value = false;
    }
    isLoadingItemPaging.value = true;
    var rs = await deliverRepository.getPagingItemInDelivery(params);
    isLoadingItemPaging.value = false;

    if (rs.ok()) {
      this.page.value = page;
      this.count.value = rs.data['paging']['count'];
      var listOfData = rs.data['data'] as List;

      // if (listOfData.length < size + 1) {
      //   emptyData.value = true;
      // } else {
      //   listOfData.removeLast();
      // }
      if (rs.data['paging']['count'] < size + 1) {
        emptyData.value = true;
      }
      this.listPackage.addAll(listOfData);
    }
  }

  onLoadMorePackage() async {
    onLoadPagingItemList(page: this.page.value + 1);
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
                onTap: () {
                  launch(
                      "tel: ${nguoiThucNhanFullInfo.value['receiverPhone']}");
                  createHisCall(
                    name: nguoiThucNhanFullInfo.value['receiverFullName'],
                    phone: nguoiThucNhanFullInfo.value['receiverPhone'],
                    receiverAddress: itemData['receiverCustomerAddress'],
                    itemsIgnore: [...listPackageIgnore.value],
                    deliveryPointName: deliveryPointName.value,
                    deliveryPointCode: itemData['deliveryPointCode']
                  );
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
      {String receiverAddress,
        String deliveryPointCode,
        String deliveryPointName,
        List<dynamic> itemsIgnore,
        String phone,
        String name}) async {
    // var rs = await commonRepository.createCallMulti(
    //   phone: phone,
    //   name: name,
    //   deliveryPointCode: deliveryPointCode,
    //   deliveryPointName: deliveryPointName,
    //   itemsIgnore: itemsIgnore,
    //   receiverAddress: receiverAddress
    // );
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
        .findOneDeliveryPointReceive(param['deliveryPointReceiver']);
    if (rs.ok()) {
      nguoiThucNhanFullInfo.value = rs.data;
    }
  }

  pathValueForm(Map value) {
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
      deliveryPointReceiver.value = deliveryPointReceiver.value;
    }
    if (value['deliveryNote'] != null) {
      deliveryNote.value = value['deliveryNote'];
    }
    if (value['causeCode'] != null) {
      causeCode.value = value['causeCode'];
    }
    if (value['attachFile'] != null) {
      attachFile.value = json.decode(value['attachFile']);
    }
    if (value['buttonText'] != null) {
      buttonText.value = value['buttonText'];
    }
    if (value['realReciverName'] != null) {
      realReciverName.value = value['realReciverName'];
    }
    if (value['callHistory'] != null) {
      callHistory.value = (value['callHistory']);
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
      "attachFile":
          attachFile.length > 0 ? json.encode(attachFile.value) : null,
      "realReciverName": realReciverName.value,
      "callHistory": callHistory.value
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
    params['mailtripID'] = dataRoute['mailtripID'];
    params['mailtripID'] = dataRoute['mailtripID'];
    params['receiverAddress'] = itemData['receiverCustomerAddress'];
    params['deliveryPointCode'] = itemData['deliveryPointCode'];
    params['deliveryPointName'] = itemData['deliveryPointName'];
    params['lat'] = position.latitude;
    params['long'] = position.longitude;
    params['itemsIgnore'] = [...listPackageIgnore.value];

    var rs = await deliverRepository.onPhatMore(params);
    isSubmit.value = false;
    if (rs.ok()) {
      if (deliveryDetailController != null) {
        deliveryDetailController.listViewPagingKey.currentState.getData();
      }
      await DialogService.alert(message: '${buttonText.value} thành công');
      Get.back();
    } else {
      bindError(rs.getErrorObject());
      DialogService.error(message: rs.getMsgError());
    }
  }
}
