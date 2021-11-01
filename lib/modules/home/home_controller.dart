import 'package:bccp_mobile_v2/core/services/config_server_service.dart';
import 'package:bccp_mobile_v2/core/services/config_service.dart';
import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/services/position_service.dart';
import 'package:bccp_mobile_v2/core/utils/helpers.dart';
import 'package:bccp_mobile_v2/data/model/home/weather_model.dart';
import 'package:bccp_mobile_v2/data/model/response_model.dart';
import 'package:bccp_mobile_v2/data/provider/home/home_provider.dart';
import 'package:bccp_mobile_v2/data_service/repositories/common/common_repositoty.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  PositionService positionService = Get.find();
  ConfigService configService = Get.find();
  ConfigServerService configServiceService = Get.find();
  HomeProvider homeProvider;
  CommonRepository commonRepository;
  HomeController({this.homeProvider, this.commonRepository});

  final weekDay = ''.obs;
  final dateNow = ''.obs;
  final message = ''.obs;
  final texture = 'assets/images/weathers/rain.jpg'.obs;

  final myLocation = ''.obs;
  final myTemp = 0.0.obs;
  final myWeather = WeatherModel().obs;
  final permissionLocation = true.obs;
  final loadingWeather = true.obs;

  String get myLocationText {
    return myWeather.value.name;
  }

  String get myTempText {
    if(myWeather.value.main != null) {
      return myWeather.value.main.temp.round().toString();
    }
    return '';
  }

  @override
  void onInit() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      permissionLocation.value = false;
      loadingWeather.value = false;
    } else {
      permissionLocation.value = true;
    }
    getWeather();
    getTime();
    super.onInit();
    checkVersion();
  }

  checkVersion() async {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // var appVersion = packageInfo.version;
    // var newVersion;
    // var rs = await commonRepository.getVersion();
    // if (rs.ok()) {
    //   newVersion = rs.data['version'];
    //   configService.setConfig(version: newVersion);
    // }
    // if (newVersion != appVersion) {
    //   DialogService.confirm(message: 'Đã có bản cập nhật mới, bạn có muốn cập nhật không');
    // }
    // print(rs);
    var rs = await configServiceService.checkVersion();
    if(rs['isHasNewVersion']) {
      var conf = await DialogService.confirm(message: 'Có một bản cập nhật mới, bạn có muốn cập nhật không?');
      if (conf) {
        launch(rs['urlDownload']);
      }
    }

    // if(rs['isHasNewVersion']) {
    //   var rs =
    // }
  }

  Future<void> scanQrCode() async {
    // Get.toNamed(Routes.TEST_CONTROL);
    // return;

    await Permission.camera.request();
    String photoScanResult = await scanner.scan();
    if (photoScanResult.isNotEmpty) {
      Get.toNamed(Routes.SEARCH,
          arguments: photoScanResult);
      // DialogService.alert(message: 'Chức năng đang phát triển');
    }
  }

  Future<void> getWeather() async {
    if(!permissionLocation.value) {
      return;
    }
    // if (await Permission.location.request().isGranted) {
    //   // Either the permission was already granted before or the user just granted it.
    // }
    loadingWeather.value = true;
    Position position = await positionService.getPosition();
    ResponseModel<WeatherModel> rs = await homeProvider.getWeather(lat: position.latitude, long: position.longitude);
    loadingWeather.value = false;
    if(rs.ok()) {
      myWeather.value = rs.data;
      int kind = int.parse(rs.data.weather[0].icon.substring(0, 2));

      message.value = getMessage(kind);
      texture.value = getUrlAssetTexture(kind);
    }
  }

  Future<void> getTime() async {
    weekDay.value = Helpers.getDayOfWeek();
    dateNow.value = Helpers.getDateNow();
  }

  String getUrlAssetTexture(int id) {
    // - assets/images/weathers/clear_sky.jpg
    //     - assets/images/weathers/dark_cloud.jpg
    //     - assets/images/weathers/few_cloud.png
    //     - assets/images/weathers/rain.jpg
    //     - assets/images/weathers/sky_rain.jpg
    if (id < 2) {
      return 'assets/images/weathers/clear_sky.jpg';
    } else if (id >= 2 && id < 4) {
      return 'assets/images/weathers/few_cloud.png';
    } else if (id >= 4 && id < 5) {
    return 'assets/images/weathers/dark_cloud.jpg';
    } else {
      return 'assets/images/weathers/sky_rain.jpg';
    }
  }

  String getMessage(int id) {
    // - assets/images/weathers/clear_sky.jpg
    //     - assets/images/weathers/dark_cloud.jpg
    //     - assets/images/weathers/few_cloud.png
    //     - assets/images/weathers/rain.jpg
    //     - assets/images/weathers/sky_rain.jpg
    if (id < 2) {
      return 'Nắng nhiều đấy';
    } else if (id >= 2 && id < 4) {
      return 'Trời trong xanh mây trắng trong lành';
    } else if (id >= 4 && id < 5) {
      return 'Trời mát mẻ thích hợp cho\nmột ngày làm việc năng động';
    } else {
      return 'Có thể bạn sẽ cần đến áo mưa';
    }
  }
}
