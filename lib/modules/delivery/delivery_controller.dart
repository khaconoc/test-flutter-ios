import 'dart:convert';

import 'package:bccp_mobile_v2/core/services/auth_service.dart';
import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/position_service.dart';
import 'package:bccp_mobile_v2/widgets/app_listview.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController {
  PositionService positionService = Get.find();
  AuthService authService = Get.find();

  // ReceiveController();
  final listDelivery = [].obs;
  final textDeliverySearch = ''.obs;
  final status = Rxn<int>(2);
  final isLoading = false.obs;

  final whereDeliveryList = {}.obs;

  final params = {}.obs;
  var defaultParams = {};

  var reloadListView = 0.obs;

  GlobalKey<AppListViewState> listViewPagingKey = GlobalKey();

  Position position;

  @override
  void onInit() async {
    debounce(textDeliverySearch, (_) {
      onChangeParamsList();
    }, time: Duration(milliseconds: 800));

    onChangeParamsList();

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setTextDeliverySearch(String value) {
    this.textDeliverySearch.value = value;
  }

  onChangeStatus(int value) async {
    status.value = value;
    onChangeParamsList();
  }

  onChangeParamsList() {
    Map<String, dynamic> jsonParams = json.decode(json.encode(defaultParams));
    if (textDeliverySearch.value.isNotEmpty) {
      jsonParams['deliveryRouteName'] = textDeliverySearch.value;
    }
    if (status.value != null) {
      jsonParams['status'] = status.value;
    }

    params.value = jsonParams;
  }
}
