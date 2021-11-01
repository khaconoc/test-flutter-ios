import 'dart:convert';

import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:bccp_mobile_v2/widgets/app_listview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiveController extends GetxController {
  final customer = ''.obs;
  final status = Rxn<int>(2);
  var listRequestAccepted = [].obs;
  final params = {}.obs;
  var defaultParams = {};

  final textSearch = ''.obs;

  GlobalKey<AppListViewState> listViewPagingKey = GlobalKey();

  @override
  void onInit() async {
    defaultParams = Map.from({});
    // params.value = Map.from(defaultParams);
    onSearch();
    super.onInit();
    debounce(textSearch, (_) {
      onSearch();
    }, time: Duration(milliseconds: 800));
  }

  onChangeCustomer(String value) async {
    customer.value = value;
    onSearch();
  }

  onChangeStatus(int value) async {
    status.value = value;
    onSearch();
  }

  onSearch() async {
    Map<String, dynamic> tempParams = json.decode(json.encode(defaultParams));
    if (customer.value != '') {
      tempParams['senderCustomerCode'] = customer.value;
    }
    if (textSearch.value != '') {
      tempParams['senderFullName'] = textSearch.value;
    }

    if (status.value != null && status.value != 0) {
      tempParams['status'] = status.value;
    }
    params.value = tempParams;
  }

  void setTextSearch(String value) {
    textSearch.value = value;
  }

  onClear() async {
    listRequestAccepted.clear();
    update();
  }

  onDetail(Map params) async {
    await Get.toNamed(Routes.RECEIVE_REQUEST_DETAIL, arguments: params);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
