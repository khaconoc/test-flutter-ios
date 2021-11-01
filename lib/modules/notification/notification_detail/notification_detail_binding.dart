import 'package:get/get.dart';

import 'notification_detail_controller.dart';

class NotificationDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationDetailController>(() => NotificationDetailController());
  }
}