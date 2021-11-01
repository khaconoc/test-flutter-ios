import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  bool isShowingDialog = false;

  @override
  void onInit() async {
    super.onInit();
    // print('Start connectivity service ...');
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      isShowingDialog = true;
      onShowDialog();
    }

    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none && !isShowingDialog) {
        isShowingDialog = true;
        onShowDialog();
      } else {
        if (isShowingDialog) {
          Get.back();
          isShowingDialog = false;
        }
      }
    });
  }

  void onShowDialog() {
    showDialog(
      context: Get.overlayContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: CupertinoAlertDialog(
            title: Text('Vui lòng kết nối mạng để tiếp tục sử dụng'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Get.back();
                  isShowingDialog = false;
                },
                child: Text('Đóng'),
                isDestructiveAction: true,
              )
            ],
          ),
        );
      },
    );
  }
}
