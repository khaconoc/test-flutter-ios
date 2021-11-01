import 'package:bccp_mobile_v2/data_service/models/reponse_model.dart';
import 'package:bccp_mobile_v2/data_service/repositories/base_repository.dart';

class DeliverySpecRepository extends BaseRepository {

  Future<ResponseModel<String>> onHoanThanhTuyenPhat(
      {Map<String, dynamic> body}) async {
    var rs =
    await postApi(url: '/api/phat/PhatDacBiet/DeliveryUpdate', params: body);

    return ResponseModel(
      data: rs.data == null
          ? null
          : "success",
      error: rs.error,
    );
  }

  Future<ResponseModel<Map>> findOneBuuGuiOne(
      {Map<String, dynamic> body}) async {
    var rs =
    await postApi(url: '/api/phat/PhatDacBiet/ItemFindOne', params: body);

    return ResponseModel(
      data: rs.data == null
          ? null
          : rs.data,
      error: rs.error,
    );
  }

  Future<ResponseModel<Map>> findOneBuuGuiMore(
      {Map<String, dynamic> body}) async {
    var rs =
    await postApi(url: '/api/phat/PhatDacBiet/CustomerFindOne', params: body);

    return ResponseModel(
      data: rs.data == null
          ? null
          : rs.data,
      error: rs.error,
    );
  }

  Future<ResponseModel<String>> onPhatOne(Map params) async {
    var rs = await postApi(url: '/api/phat/PhatDacBiet/ItemUpdate', params: params);
    return ResponseModel(
      data: rs.data == null ? null : "success",
      error: rs.error,
    );
  }

  Future<ResponseModel<String>> onPhatMore(Map params) async {
    var rs = await postApi(url: '/api/phat/PhatDacBiet/ItemMultiUpdate', params: params);
    return ResponseModel(
      data: rs.data == null ? null : "success",
      error: rs.error,
    );
  }

  Future<ResponseModel<Map>> getPagingItemInDelivery(Map params) async {
    var rs = await postApi(url: '/api/phat/PhatDacBiet/MailtripItemGetPaging', params: params);
    return ResponseModel(
      data: rs.data == null ? null : rs.data,
      error: rs.error,
    );
  }
}
