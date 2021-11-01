import 'dart:convert';

import 'package:bccp_mobile_v2/core/services/auth_service.dart';
import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/data_service/repositories/delivery/delivery_repository.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:bccp_mobile_v2/widgets/app_listview.dart';
import 'package:bccp_mobile_v2/widgets/item_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';


class DeliverySpecController extends GetxController {
  DeliverRepository deliverRepository;
  // DeliveryController deliveryController = Get.find();

  DeliverySpecController({this.deliverRepository});

  // var mailTripId = Get.arguments['mailtripID'];

  final dataRoute = Get.arguments;
  final textSearch = ''.obs;
  final diemPhat = {}.obs;

  final listDelivery = [].obs;
  final params = {}.obs;
  Map<dynamic, dynamic> paramsDefault = {
  };

  final groupTitle = ''.obs;

  final status = Rxn<int>(0);

  Set groupTitleSet = {};

  GlobalKey<AppListViewState> listViewPagingKey = GlobalKey();

  @override
  void onInit() async {
    super.onInit();
    debounce(textSearch, (_) {
      onChangeParamsList();
    }, time: Duration(milliseconds: 800));

    onChangeParamsList();
  }

  onChangeParamsList() {
    Map<String, dynamic> jsonParams = json.decode(json.encode(paramsDefault));
    if (textSearch.value.isNotEmpty) {
      jsonParams['deliveryPointName'] = textSearch.value;
    }

    if (status.value != null) {
      jsonParams['status'] = status.value;
    }

    params.value = jsonParams;
  }

  List<dynamic> renderTitle(List<dynamic> source) {
    List<dynamic> rs = [];
    source.forEach((item) {
      var title = '${item['deliveryPointName']} ${item['receiverAddress']} ${item['deliveryPointName']}';
      if (!groupTitleSet.contains(title)) {
        rs.add({'type': 'title', ...item});
        groupTitleSet.add(title);
      }
      rs.add(item);
    });
    return rs;
  }

  void setSearch(String value) {
    textSearch.value = value;
  }

  onChangeStatus(int value) async {
    status.value = value;
    onChangeParamsList();
  }

  void onChangeDiemPhat(value) {
    Map temp = {};
    if (value != null) {
      temp = {
        "where": {
          "and": [
            {"mailtripID": dataRoute['mailtripID']},
            {"deliveryPointCode": value['deliveryPointCode']},
            {"customerCode": value['customerCode']},
            {"Status": 0}
          ]
        }
      };
    } else {
      temp = {
        "where": {
          "and": [
            {"mailtripID": dataRoute['mailtripID']},
          ]
        }
      };
    }
    this.params.value = temp;
    print(temp);
  }

  onHoanThanh() async {
    var confirm = await DialogService.confirm(
        message: 'Bạn đã hoàn thành tuyến phát này');

    if (confirm) {
      DialogService.onShowLoading(true);
      var rs = await deliverRepository.onHoanThanhTuyenPhat(body: {
        "mailtripID": dataRoute['mailtripID'],
      });
      DialogService.onShowLoading(false);
      if (rs.ok()) {
        // deliveryController.reloadListView.value++;
        await DialogService.alert(message: 'Xác nhận thành công');
        Get.back();
      } else {
        DialogService.showSnackBar('Có lỗi sảy ra', StatusSnackBar.error);
      }
    }
  }

  onOpenMap(Map data) async {
    showModalBottomSheet(
      context: Get.overlayContext,
      builder: (BuildContext bc) {
        return Container(
            padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconBottomSheet(
                    onPress: () async {
                      await Get.toNamed(Routes.DELIVERY_SPEC_SEND_MORE, arguments: data);
                      Get.back();
                    },
                    title: 'Phát nhiều',
                    image: 'assets/images/icon_send.png',
                  ),
                  IconBottomSheet(
                    onPress: () {
                      if (data['lat'] != null && data['long'] != null) {
                        MapsLauncher.launchCoordinates(data['lat'], data['long']);
                      } else {
                        MapsLauncher.launchQuery(data['area']);
                      }
                    },
                    title: 'Mở bản đồ',
                    image: 'assets/images/icon_map.png',
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconBottomSheet(
                    onPress: () async {
                      await Get.toNamed(Routes.RECEIVE_REQUEST_DETAIL,
                          arguments: {
                            'deliveryData': data
                          });
                      Get.back();
                    },
                    title: 'Tiếp nhận thường',
                    image: 'assets/images/icon_tiepnhan_bg.png',
                  ),
                  IconBottomSheet(
                    onPress: () async {
                      await Get.toNamed(Routes.RECEIVE_SPEC_REQUEST_DETAIL,
                          arguments: {
                            'deliveryData': data
                          });
                      Get.back();
                    },
                    title: 'Tiếp nhận đặc biệt',
                    image: 'assets/images/icon_tiepnhan_dacbiet_bg.png',
                  ),
                ],
              )
            ],
          )
        );
      },
    );
  }

  onPhatNhieu() {
    if (diemPhat.length < 1) {
      DialogService.alert(message: 'Phải chọn điểm phát');
      return;
    }
    Get.toNamed(Routes.DELIVERY_SEND_MORE, arguments: {
      'mailTripId': dataRoute['mailtripID'],
      'deliveryPointCode': diemPhat['deliveryPointCode'],
      'customerCode': diemPhat['customerCode']
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
