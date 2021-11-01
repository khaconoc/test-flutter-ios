import 'package:bccp_mobile_v2/core/services/localization_service.dart';
import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationExtService extends GetxService {
  final appLanguage = ''.obs;
  String get getAppLanguage => this.appLanguage.value == 'vi' ? 'Tiếng việt' : 'English';

  Future<LocalizationExtService> init() async {
    final getStore = GetStorage();
    appLanguage.value = await getStore.read(kAppLanguage) ?? 'vi';
    // LocalizationService.changeLocale(appLanguage);
    return this;
  }

  Future<void> changeAppLanguage({String lang}) async {
    this.appLanguage.value = lang;
    LocalizationService.changeLocale(lang);
  }

  Future<void> toggleAppLanguage() async {
    this.appLanguage.value = this.appLanguage.value == 'vi' ? 'en' : 'vi';
    LocalizationService.changeLocale(this.appLanguage.value);
  }

}