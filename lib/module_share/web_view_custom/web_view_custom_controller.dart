import 'package:get/get.dart';

class WebViewCustomController extends GetxController {
  final isLoading = true.obs;
  final url = Get.arguments['url'];
  final title = Get.arguments['title'];
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
