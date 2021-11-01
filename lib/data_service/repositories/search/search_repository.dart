import 'package:bccp_mobile_v2/data_service/models/co_quan_nhan_tuyen_phat_findone_model.dart';
import 'package:bccp_mobile_v2/data_service/models/customer_model.dart';
import 'package:bccp_mobile_v2/data_service/models/reponse_model.dart';
import 'package:bccp_mobile_v2/data_service/repositories/base_repository.dart';

class SearchRepository extends BaseRepository {
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
}
