import 'package:bccp_mobile_v2/data_service/models/co_quan_nhan_tuyen_phat_findone_model.dart';
import 'package:bccp_mobile_v2/data_service/models/customer_model.dart';
import 'package:bccp_mobile_v2/data_service/models/reponse_model.dart';
import 'package:bccp_mobile_v2/data_service/repositories/base_repository.dart';

class CommonRepository extends BaseRepository {
  Future<ResponseModel<CustomerModel>> findOneCustomer(
      String customerCode) async {
    var rs = await postApiKt1(
      url: '/api/Customer/FindOne',
      params: {
        'where': {
          "and": [
            {"customerCode": customerCode}
          ]
        }
      },
    );
    return ResponseModel(
        data: rs.data == null ? null : CustomerModel.fromJson(rs.data),
        error: rs.error);
  }

  Future<ResponseModel<CoQuanNhanTuyenPhatFindOneModel>> findOneTuyenPhat(
      Map<String, dynamic> data) async {
    var rs = await postApiKt1(
      url: '/api/DimDeliveryPoint/FindOne',
      params: data,
    );
    return ResponseModel(
        data: rs.data == null
            ? null
            : CoQuanNhanTuyenPhatFindOneModel.fromJson(rs.data),
        error: rs.error);
  }

  Future<ResponseModel<dynamic>> getFristDiemPhatByCoQuanNhan(
      dynamic customerCode) async {
    var rs = await postApiKt1(
      url: '/api/DimDeliveryPoint/GetComboboxCustomer',
      params: {'page': 1, 'size': 1, 'customerCode': customerCode},
    );
    return ResponseModel(
        data: rs.data == null ? null : rs.data['data'][0]['value'],
        error: rs.error);
  }

  Future<ResponseModel<Map>> findOneDeliveryPointReceive(String code) async {
    var rs = await postApiKt1(
      url: '/api/DeliveryPointReceiver/FindOne',
      params: {
        'where': {
          "and": [
            {"deliveryPointReceiverCode": code}
          ]
        }
      },
    );
    return ResponseModel(
        data: rs.data == null ? null : rs.data, error: rs.error);
  }

  Future<ResponseModel<Map>> createDeliveryPointReceive(
      Map<String, dynamic> params) async {
    var rs = await postApi(
      url: '/api/phat/DeliveryPointReceiver/Create',
      params: params,
    );
    return ResponseModel(
        data: rs.data == null ? null : rs.data, error: rs.error);
  }

  Future<ResponseModel<dynamic>> createCall(Map<String, dynamic> params) async {
    var rs = await postApi(
      url: '/api/extend/CallHistory/Create',
      params: params,
    );
    return ResponseModel(
        data: rs.data == null ? null : rs.data, error: rs.error);
  }

  Future<ResponseModel<dynamic>> createCallMulti(
      {String receiverAddress,
      String deliveryPointCode,
      String deliveryPointName,
      List<dynamic> itemsIgnore,
      String phone,
      String name}) async {
    var rs = await postApi(
      url: '/api/extend/CallHistory/MultiCreate',
      params: {
        "receiverAddress": receiverAddress,
        "deliveryPointCode": deliveryPointCode,
        "deliveryPointName": deliveryPointName,
        "itemsIgnore": itemsIgnore,
        "phone": phone,
        "name": name
      },
    );
    return ResponseModel(
        data: rs.data == null ? null : rs.data, error: rs.error);
  }

  Future<ResponseModel<Map>> getVersion() async {
    var rs = await postApiKt1(url: '/api/DimFile/GetPaging', params: {
      "page": 1,
      "size": 1,
      "order": {"version": false},
      "where": {
        "and": [
          {"type": 1}
        ]
      }
    });
    return ResponseModel(
        data: rs.data == null ? null : (rs.data['data'][0]),
        error: rs.error);
  }
}
