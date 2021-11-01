import 'package:bccp_mobile_v2/data/provider/home/home_provider.dart';
import 'package:bccp_mobile_v2/data/repositories/home/home_repository.dart';
import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'package:bccp_mobile_v2/modules/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        homeProvider: HomeProvider(
          homeRepository: HomeRepository(),
        ),
        commonRepository: CommonRepository()
      ),
    );
  }
}
