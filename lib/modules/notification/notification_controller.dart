import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> onMaskSeenAll() async {
    bool confirm = await DialogService.confirm(message: 'Đánh dấu xem tất cả');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
