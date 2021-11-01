import 'package:bccp_mobile_v2/modules/notification/notification_controller.dart';
import 'package:get/get.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}