import 'dart:async';
import 'dart:convert';

import 'package:bccp_mobile_v2/core/services/config_service.dart';
import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfigServerService extends GetxService {
  ConfigService _configService = Get.find();
  HttpService _httpService = Get.find();
  String version = '';
  final isHasNerVersion = false.obs;

  Future<ConfigServerService> init() async {
    final getStore = GetStorage();
    return this;
  }

  Future<Map> checkVersion() async {
    String _url = '${BaseRepository.dimPagingApi}';
    var rs = await _httpService.dio.post(
      _url,
      data: {
        "page": 1,
        "size": 1,
        "order": {"version": false},
        "where": {
          "and": [
            {"type": 1}
          ]
        }
      },
      options: Options(
        // contentType: Headers.formUrlEncodedContentType, // form data
          followRedirects: false,
          validateStatus: (status) {
            return true;
          }),
    );

    if (rs.statusCode == 200) {
      var data = rs.data['data'][0];
      int appVersion = int.tryParse(_configService.version.replaceAll('.', ''));
      int currentVersion = int.tryParse(data['version'].toString().replaceAll('.', ''));
      if (currentVersion > appVersion) {
        isHasNerVersion.value = true;
        var attackFile = json.decode(data['attackFile'])[0];
        var url = '${BaseRepository.baseUrl}${attackFile['fileUrl']}';
        return { 'isHasNewVersion': true, 'urlDownload' : url};
      }
    }
    return { 'isHasNewVersion': false, 'urlDownload' : '' };
  }

}