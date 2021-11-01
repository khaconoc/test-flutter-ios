import 'package:bccp_mobile_v2/data_service/models/reponse_model.dart';
import 'package:bccp_mobile_v2/data_service/repositories/base_repository.dart';

class DeliveryHistoryRepository extends BaseRepository {

  Future<ResponseModel<Map<String, dynamic>>> getAllHisItem(
      dynamic itemId, dynamic deliveryIndex) async {
    var rs =
    await postApi(url: '/api/extend/ItemHistory/GetPaging', params: {
      'page': 1,
      'size': 100,
      'itemId': itemId,
      'deliveryIndex': deliveryIndex
    });

    return ResponseModel(
      data: rs.data == null
          ? null
          : rs.data,
      error: rs.error,
    );
  }

  Future<ResponseModel<Map<String, dynamic>>> getAllHisCall(
      dynamic itemId) async {
    var rs =
    await postApi(url: '/api/extend/CallHistory/GetPaging', params: {
      'page': 1,
      'size': 100,
      'itemId': itemId
    });

    return ResponseModel(
      data: rs.data == null
          ? null
          : rs.data,
      error: rs.error,
    );
  }
}
