import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:bccp_mobile_v2/data_service/models/reponse_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

abstract class BaseRepository {

  static Map env = appEnv;
  ///dev
  static String baseUrlKt1 = env['baseUrl'];
  static String baseUrl = env['baseUrlNew'];

  /// dev
  // static const baseUrlKt1 = 'https://vnpost.ddns.net/kt1';
  // static const baseUrl = 'https://vnpost.ddns.net/mobile';

  /// poc
  // static const baseUrlKt1 = 'https://vnpost.ddns.net/poc/kt1';
  // static const baseUrl = 'https://vnpost.ddns.net/poc/mobile';

  /// link deploy product
  // static const baseUrlKt1 = 'https://vnpost.ddns.net/kt1';
  // static const baseUrl = 'http://45.252.243.4/mobile-api-gate-way';

  HttpService _httpService = Get.find();

  bindResponseApi<T>(Response response) {
    if (response.statusCode == 200) {
      return ResponseModel(data: response.data);
    } else {
      print(response);
    }
    var result =  ResponseModel(error: response.data);
    return result;
  }

  Future<ResponseModel> postApiKt1({String url, Map<String, dynamic> params}) async {
    Response rs;
    try {
      rs = await _httpService.dio.post(
        baseUrlKt1 + url,
        data: params,
        options: Options(
          // contentType: Headers.formUrlEncodedContentType, // form data
            followRedirects: false,
            validateStatus: (status) {
              return true;
            }),
      );
    } catch (e) {
      rs = new Response(requestOptions: null);
      rs.statusCode = 500;
      rs.data = '{"status":500,"errors":{"":["Lỗi hệ thống"]}}';
    }
    return bindResponseApi(rs);
  }

  Future<ResponseModel> postApi({String url, Map<String, dynamic> params}) async {
    Response rs;
    try {
      rs = await _httpService.dio.post(
        baseUrl + url,
        data: params,
        options: Options(
          // contentType: Headers.formUrlEncodedContentType, // form data
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        ),
      );
    } catch (e) {
      rs = new Response(requestOptions: null);
      rs.statusCode = 500;
      rs.data = '{"status":500,"errors":{"":["Lỗi hệ thống"]}}';
    }
    return bindResponseApi(rs);
  }

  Future<ResponseModel<T>> getApi<T>({String url, Map<String, dynamic> params}) async {
    var rs = await _httpService.dio.get(
      baseUrl + url,
      queryParameters: params,
      options: Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          }),
    );
    return bindResponseApi<T>(rs);
  }

  Future<ResponseModel> comboBoxApi({String url, Map<String, dynamic> params}) async {
    var rs = await _httpService.dio.post(
      baseUrl + url,
      data: params,
      options: Options(
        // contentType: Headers.formUrlEncodedContentType, // form data
          followRedirects: false,
          validateStatus: (status) {
            return true;
          }),
    );
    return bindResponseApi(rs);
  }
}

