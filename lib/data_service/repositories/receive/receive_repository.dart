import 'package:bccp_mobile_v2/data_service/models/reponse_model.dart';

import '../base_repository.dart';

class ReceiveRepository extends BaseRepository {
  Future<ResponseModel<Map>> findOneRequestAccepted(
      Map<String, dynamic> data) async {
    var rs = await postApi(
      url: '/api/tiepnhan/TiepNhanThuong/RequestFindOne',
      params: data,
    );
    return ResponseModel(
        data: rs.data == null ? null : rs.data,
        error: rs.error);
  }

  Future<ResponseModel<Map<String, dynamic>>> getPagingItemList(
      Map<String, dynamic> data) async {
    var rs = await postApi(
      url: '/api/tiepnhan/TiepNhanThuong/ItemGetPaging',
      params: data,
    );
    return ResponseModel(
        data: rs.data == null ? null : rs.data,
        error: rs.error);
  }


  Future<ResponseModel<String>> capNhatyeuCau(
      Map<String, dynamic> data) async {
    var rs = await postApi(
      url: '/api/tiepnhan/TiepNhanThuong/RequestUpdate',
      params: data,
    );
    return ResponseModel(
        data: rs.data == null ? null : "success",
        error: rs.error);
  }

  Future<ResponseModel<String>> capNhatBuuGui(
      Map<String, dynamic> data) async {
    var rs = await postApi(
      url: '/api/tiepnhan/TiepNhanThuong/ItemUpdate',
      params: data,
    );
    return ResponseModel(
        data: rs.data == null ? null : "success",
        error: rs.error);
  }

  Future<ResponseModel<Map>> findOneBuuGui(
      Map<String, dynamic> data) async {
    var rs = await postApi(
      url: '/api/tiepnhan/TiepNhanThuong/ItemFindOne',
      params: data,
    );
    return ResponseModel(
        data: rs.data == null ? null : rs.data,
        error: rs.error);
  }

  Future<ResponseModel<String>> deleteBuuGui(
      Map<String, dynamic> data) async {
    var rs = await postApi(
      url: '/api/tiepnhan/TiepNhanThuong/ItemDelete',
      params: data,
    );
    return ResponseModel(
        data: rs.data == null ? null : 'success',
        error: rs.error);
  }

}