import 'package:bccp_mobile_v2/data/model/login/login_response_model.dart';
import 'package:bccp_mobile_v2/data/model/login/user_model.dart';
import 'package:bccp_mobile_v2/data/model/response_model.dart';
import 'package:bccp_mobile_v2/data/repositories/login/login_repository.dart';
import 'package:dio/dio.dart';

class LoginProvider {
  LoginRepository _loginRepository;

  LoginProvider(LoginRepository loginRepository) {
    _loginRepository = loginRepository;
  }

  Future<ResponseModel<LoginResponseModel>> login ({String userName, String passWord}) async {
    Response rs = await _loginRepository.login(userName: userName, passWord: passWord);
    if(rs.statusCode == 200) {
      var body = LoginResponseModel.fromJson(rs.data);
      return Future.value(ResponseModel(data: body, statusCode: rs.statusCode));
    } else {
      return Future.value(ResponseModel(data: null, statusCode: rs.statusCode));
    }
  }

  Future<ResponseModel<UserModel>> getUserInfo () async {
    Response rs = await _loginRepository.getUserInfo();
    if(rs.statusCode == 200) {
      var body = UserModel.fromJson(rs.data);
      return Future.value(ResponseModel(data: body, desc: 'thanh cong', statusCode: rs.statusCode));
    } else {
      return Future.value(ResponseModel(data: null, desc: 'co loi trong qua trinh xu ly', statusCode: rs.statusCode));
    }
  }
}