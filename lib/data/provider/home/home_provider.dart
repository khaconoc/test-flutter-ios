import 'package:bccp_mobile_v2/data/model/home/weather_model.dart';
import 'package:bccp_mobile_v2/data/model/response_model.dart';
import 'package:bccp_mobile_v2/data/repositories/home/home_repository.dart';
import 'package:dio/dio.dart';

class HomeProvider {
  HomeRepository homeRepository;

  HomeProvider({this.homeRepository});

  Future<ResponseModel<WeatherModel>> getWeather ({double lat, double long}) async {
    Response rs = await homeRepository.getWeather(lat: lat, long: long);
    if(rs.statusCode == 200) {
      var body = WeatherModel.fromJson(rs.data);
      return Future.value(ResponseModel(data: body, statusCode: rs.statusCode));
    } else {
      return Future.value(ResponseModel(data: null, statusCode: rs.statusCode));
    }
  }
}