import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomDialogService extends GetxService {
  String token = '';

  Future<CustomDialogService> init() async {
    return this;
  }

  void onShowLoading(bool isShow) {
    if(isShow) {
      showDialog(
        context: Get.overlayContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: CupertinoAlertDialog(
              title: Text(
                  'Loading....'),
            ),
          );
        },
      );
    } else {
      Get.back();
    }
  }
}
