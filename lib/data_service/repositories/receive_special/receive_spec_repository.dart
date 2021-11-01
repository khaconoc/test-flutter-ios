import 'package:bccp_mobile_v2/data_service/models/reponse_model.dart';

import '../base_repository.dart';

class ReceiveSpecRepository extends BaseRepository {
  Future<ResponseModel<Map>> findOneRequestAccepted(
      Map<String, dynamic> data) async {
    var rs = await postApi(
      url: '/api/tiepnhan/TiepNhanDacBiet/RequestFindOne',
      params: data,
    );
    return ResponseModel(
        data: rs.data == null ? null : rs.data,
        error: rs.error);
  }

  Future<ResponseModel<Map<String, dynamic>>> getPagingItemList(
      Map<String, dynamic> data) async {
    var rs = await postApi(
      url: '/api/tiepnhan/TiepNhanDacBiet/ItemGetPaging',
      params: data,
    );
    return ResponseModel(
        data: rs.data == null ? null : rs.data,
        error: rs.error);
  }

  Future<ResponseModel<String>> capNhatyeuCau(
      Map<String, dynamic> data) async {
    var rs = await postApi(
      url: '/api/tiepnhan/TiepNhanDacBiet/RequestUpdate',
      params: data,
    );
    return ResponseModel(
        data: rs.data == null ? null : "success",
        error: rs.error);
  }

  Future<ResponseModel<String>> capNhatBuuGui(
      Map<String, dynamic> data) async {
    var rs = await postApi(
      url: '/api/tiepnhan/TiepNhanDacBiet/ItemUpdate',
      params: data,
    );
    return ResponseModel(
        data: rs.data == null ? null : "success",
        error: rs.error);
  }

  Future<ResponseModel<Map>> findOneBuuGui(
      Map<String, dynamic> data) async {
    var rs = await postApi(
      url: '/api/tiepnhan/TiepNhanDacBiet/ItemFindOne',
      params: data,
    );
    return ResponseModel(
        data: rs.data == null ? null : rs.data,
        error: rs.error);
  }

  Future<ResponseModel<String>> deleteBuuGui(
      Map<String, dynamic> data) async {
    var rs = await postApi(
      url: '/api/tiepnhan/TiepNhanDacBiet/ItemDelete',
      params: data,
    );
    return ResponseModel(
        data: rs.data == null ? null : 'success',
        error: rs.error);
  }
}