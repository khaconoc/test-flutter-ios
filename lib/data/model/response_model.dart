import 'package:bccp_mobile_v2/data/model/base_model.dart';

class ResponseModel<T> {
  bool status;
  String desc;
  T data;
  int statusCode;
  ResponseModel({this.data, this.desc, this.statusCode}) {
    if(statusCode == 200) {
      status = true;
      desc = 'Thành công';
    } else {
      status = false;
      desc = 'Có lỗi khi lấy dữ liệu';
    }
  }

  ResponseModel parseJson(json, BaseModel target) {
    return ResponseModel(
      statusCode: json['status'],
      desc: json['message'],
      data: target.fromJson(json['data']),
    );
  }

  bool ok() {
    return status;
  }
}

class ResponsePagingModel<T> {
  bool status;
  String desc;
  List<T> data;
  PagingModel paging;
  ResponsePagingModel({this.data, this.desc, this.status, this.paging});

  bool ok() {
    return status;
  }
}

class PagingModel {
  int count;
  int page;
  int size;

  PagingModel({this.count, this.page, this.size});

  PagingModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    page = json['page'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['page'] = this.page;
    data['size'] = this.size;
    return data;
  }
}
