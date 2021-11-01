import 'package:get/get.dart';
import 'package:bccp_mobile_v2/data_service/repositories/delivery_history/dlivery_history_repository.dart';

class DeliveryHistoryController extends GetxController {
  DeliveryHistoryRepository deliveryHistoryRepository;

  DeliveryHistoryController({this.deliveryHistoryRepository});

  final itemId = Get.arguments['itemID'];
  final deliveryIndex = Get.arguments['deliveryIndex'];
  final title = 'Lịch sử'.obs;
  final listOfDataHisItem = [].obs;
  final isLoadingHisItem = false.obs;
  final listOfDataHisCall = [].obs;
  final isLoadingHisCall = false.obs;
  @override
  void onInit() async {
    super.onInit();
    title.value = Get.arguments['itemCode'];
    getHisItem(itemId, deliveryIndex);
    getHisCall(itemId);
  }

  getHisItem(dynamic itemId, dynamic deliveryIndex) async {
    isLoadingHisItem.value = true;
    var rs = await deliveryHistoryRepository.getAllHisItem(itemId, deliveryIndex);
    await 0.3.delay();
    isLoadingHisItem.value = false;
    if(rs.ok()) {
      listOfDataHisItem.addAll(rs.data['data']);
    }
  }

  getHisCall(dynamic itemId) async {
    isLoadingHisCall.value = true;
    var rs = await deliveryHistoryRepository.getAllHisCall(itemId);
    await 0.3.delay();
    isLoadingHisCall.value = false;
    if(rs.ok()) {
      listOfDataHisCall.addAll(rs.data['data']);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
