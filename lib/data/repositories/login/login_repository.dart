
import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

class LoginRepository extends BaseRepository {
  HttpService _httpService = Get.find();

  Future<Response> login({String userName, String passWord}) async {
    String _url = '${BaseRepository.loginApi}';
    var rs = await _httpService.dio.post(
      _url,
      data: {
        'client_id': 'huokgu&549^nb)(*3s23#4',
        'client_secret': 'eb601de6-ydc4-34u2-g4ug-abd3c72h4019',
        'grant_type': 'password',
        'scope': 'profile email api1.read api1.write offline_access',
        'username': userName,
        // 'username': '100000',
        // 'password': 'Password123!'
        'password': passWord
      },
      options: Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          }),
    );
    return rs;
  }

  Future<Response> getUserInfo() async {
    String _url = '${BaseRepository.userInfoApi}';
    var rs = await _httpService.dio.get(
      _url,
      options: Options(
        // headers: {
        //   'Authorization': 'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjlEMUM1NjdENEE2MzRCQUVCNjIzRjAwMTcyQ0JDRERBIiwidHlwIjoiYXQrand0In0.eyJuYmYiOjE2MTkyNTc2NzEsImV4cCI6MTYxOTM0NDA3MSwiaXNzIjoiaHR0cHM6Ly92bnBvc3QuZGRucy5uZXQvc3NvIiwiYXVkIjoiYXBpMSIsImNsaWVudF9pZCI6Imh1b2tndSY1NDlebmIpKCozczIzIzQiLCJzdWIiOiI4OTBERTEzMy1CMzk4LTRGOTktQUFENi1FOTRBMTNEQjNCOEYiLCJhdXRoX3RpbWUiOjE2MTkyNTc2NzAsImlkcCI6ImxvY2FsIiwicm9sZSI6WyJBZG1pbiIsIlF14bqjbiBUcuG7iyBI4buHIFRo4buRbmciXSwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiIxMDAwMDAiLCJqdGkiOiI3MDdEQUVFQzYxQzUwQjFDNkFGNkI3RTU2OEU3QkFBMiIsImlhdCI6MTYxOTI1NzY3MSwic2NvcGUiOlsiYXBpMS5yZWFkIiwiYXBpMS53cml0ZSIsImVtYWlsIiwicHJvZmlsZSJdLCJhbXIiOlsicHdkIl19.bpUODzMGMdXJnXzg-WQRgchzu1hbu7RzSzX-PnT90aQghX5TcPA2iRZLhwReu4xazYxwJoe7yaRBP4439-2Qs3ymwjB_avdE56V2FySu_oUt0Nwk9fECn35KyJMlB2066oCKpayipsXJDOM14uygFkoHjesXntMB1jNMJJaCBqcEYR8jWWv1qIcN0uHPNAF12EG2AGHocLvmRnUcQvd6Nt0YhORklXbkTeWQ7bNnlCzVNCpGIpMGaM3LhwqL_MwuVAiA0360q8vxrNYmJ-xljTMOqS9B_rYtmcOYu_pKAPInpxTNIe3dbbzGb4W4EPpseXff_miAEcE-MHvzy2t85A'
        // },
        followRedirects: false,
        validateStatus: (status) {
          return true;
        },
      ),
    );
    return rs;
  }
}
