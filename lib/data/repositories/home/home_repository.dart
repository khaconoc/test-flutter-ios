import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/data/model/home/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../base_repository.dart';

class HomeRepository {
  HttpService _httpService = Get.find();

  Future<Response> getWeather({double lat, double long}) async {
    String _url = '${BaseRepository.getWeatherApi}';
    var rs = await _httpService.dio.get(
      _url,
      queryParameters: {
        'lat': lat,
        'lon': long,
        'units': 'metric',
        'lang': 'vi',
        'appid': '2501ca357b8763ddf4514109c0daf62a'
      },
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return true;
        },
      ),
    );
    return rs;
  }
}
