import 'dart:convert';
import 'package:bccp_mobile_v2/core/extentions/string_extention.dart';

class ResponseModel<T> {
  T data;
  dynamic error;

  bool ok() {
    return error == null;
  }

  ResponseModel({this.data, this.error});

  String getMsgError() {
    String msg = '';
    try {
      if (this.error is String) {
        var errors = json.decode(this.error)['errors'];
        errors.forEach((k, v) {
          if(msg == '') {
            msg = v[0].toString().maxLength(len: 500);
          }
        });
      }
      if (this.error is Map) {
        Map errors = this.error['errors'];
        errors.forEach((k, v) {
          if(msg == '') {
            msg = v[0].toString().maxLength(len: 500);
          }
        });
      }
    } catch (e) {
    }
    return msg;
  }

  Map getErrorObject() {
    try {
      if (this.error is String) {
        return json.decode(this.error)['errors'];
      }
      if (this.error is Map) {
        return this.error['errors'];
      }
    } catch (e) {}
    return {};
  }
}
