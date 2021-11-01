import 'dart:async';

import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;


class UtilsService extends GetxService {

  Future<UtilsService> init() async {
    return this;
  }

  Future<String> scanCode() async {
    await Permission.camera.request();
    String result = await scanner.scan();
    if(result.isNotEmpty) {
      return result;
    }
    return '';
  }

}