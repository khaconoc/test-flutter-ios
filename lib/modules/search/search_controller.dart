import 'dart:convert';

import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:bccp_mobile_v2/widgets/app_listview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var textSearch = ''.obs;
  final listOfData = <String>[].obs;
  final isLoading = false.obs;
  FocusNode myFocusNode = FocusNode();
  final code = Get.arguments;

  GlobalKey<AppListViewState> listViewPagingKey = GlobalKey();
  var listOfDataSearch = [].obs;
  final params = {}.obs;
  var defaultParams = {};

  TextEditingController textEditingController = new TextEditingController();

  @override
  void onInit() async {
    debounce(textSearch, (_) {
      onSearch();
    }, time: Duration(milliseconds: 800));
    super.onInit();
    await Future.delayed(const Duration(milliseconds: 300));
    myFocusNode.requestFocus();
    if(code != null && code != '') {
      textEditingController.text = code;
    }

    defaultParams = Map.from({
      "code":"M1629473409VN"
    });
    params.value = Map.from(defaultParams);
    onSearch();
  }

  onSearch() async {
    Map<String, dynamic> tempParams = json.decode(json.encode(defaultParams));

    if (textEditingController.text != '') {
      tempParams['code'] = textEditingController.text;
    }
    params.value = tempParams;
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  void setValueSearchText(String value) {
    textSearch.value = value;
  }
}
