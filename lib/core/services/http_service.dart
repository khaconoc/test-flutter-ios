import 'dart:async';
import 'dart:convert';

import 'package:bccp_mobile_v2/core/services/auth_service.dart';
import 'package:bccp_mobile_v2/core/services/config_service.dart';
import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/identity_service.dart';
import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HttpService extends GetxService {
  Dio _dio;
  String token;
  IdentityService _identityService = Get.find();
  ConfigService _configService = Get.find();

  Timer timerRefreshToken;

  get dio => this._dio;

  Future<HttpService> init(Dio dio) async {
    token = _identityService.token;

    _dio = dio;
    _dio.options.connectTimeout = 25000; //15s
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      // Do something before request is sent
      if (!token.isBlank) {
        options.headers["Authorization"] = "Bearer " + token;
      }
      print(options.uri);

      if (_configService.devMode) {
        bool rs = await DialogService.confirm(message: '${options.uri}\n\n${options.data}');
        if (rs) {
          Clipboard.setData(ClipboardData(
              text: '${options.data}'));
        }
      }
      options.validateStatus = (status) {
        return true;
      };
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      if (response.statusCode == 401) {
        Get.toNamed(Routes.LOGIN);
        return;
      }
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    },
        onError: (DioError e, handler) {
      // Do something with response error
      if (e.type == DioErrorType.other ||
          e.type == DioErrorType.connectTimeout) {
        // DialogService.onShowLoading(false);
        // DialogService.showSnackBar(
        //     'Vui lòng kiểm tra lại kết nối mạng', StatusSnackBar.error);
        // DialogService.error(message: 'Lỗi thao tác');
      }
      // Response res = new Response();
      // return handler.next(res); //continue
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }
    ));

    return this;
  }

  void setToken(String token) async {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // _dio.lock();
        options.headers["Authorization"] = "Bearer " + token;
        options.validateStatus = (status) {
          return true;
        };
        // _dio.unlock();
        return handler.next(options);
      },
    ));
  }

  scheduleRefreshToken({int milliseconds}) {
    print('set schedule refresh token after: $milliseconds');
    if (timerRefreshToken != null) {
      timerRefreshToken.cancel();
    }
    timerRefreshToken = new Timer(new Duration(milliseconds: milliseconds), () {
      fetchNewToken();
    });
  }

  cancelScheduleRefreshToken() {
    if (timerRefreshToken != null) {
      timerRefreshToken.cancel();
    }
    print('cancel refresh token');
  }

  fetchNewToken() async {
    // DialogService.showSnackBar('lam moi token', StatusSnackBar.success);
    if (timerRefreshToken != null) {
      timerRefreshToken.cancel();
    }
    String _url = '${BaseRepository.loginApi}';
    var rs = (await dio.post(
      _url,
      data: {
        'client_id': kClientId,
        'client_secret': kClientSecret,
        'grant_type': 'refresh_token',
        'refresh_token': _identityService.refreshToken
      },
      options: Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          }),
    ) as Response);

    if (rs.statusCode == 200) {
      _identityService.setIdentity(
        token: rs.data['access_token'],
        refreshToken: rs.data['refresh_token'],
      );
      setToken(rs.data['access_token']);
      scheduleRefreshToken(
          milliseconds: _identityService.getCountTimeRefresh());
    } else {
      /// neu refresh token that bai thi 1 phut sau goi lai
      scheduleRefreshToken(milliseconds: 60 * 1000);
    }
  }

  Future<bool> login({String userName, String passWord}) async {
    String _url = '${BaseRepository.loginApi}';
    var rs = await _dio.post(
      _url,
      data: {
        'client_id': kClientId,
        'client_secret': kClientSecret,
        'grant_type': 'password',
        'scope': kScope,
        'username': userName,
        'password': passWord
      },
      options: Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          }),
    );

    if (rs.statusCode == 200) {
      _identityService.setIdentity(
        token: rs.data['access_token'],
        refreshToken: rs.data['refresh_token'],
      );
      setToken(rs.data['access_token']);
      scheduleRefreshToken(milliseconds: _identityService.getCountTimeRefresh());
      return true;
    }

    return false;
  }
}
