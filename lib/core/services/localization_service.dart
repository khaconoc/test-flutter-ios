import 'dart:collection';

import 'package:bccp_mobile_v2/core/values/translations/langs/en.dart';
import 'package:bccp_mobile_v2/core/values/translations/langs/vi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationService extends Translations {

// locale sẽ được get mỗi khi mới mở app (phụ thuộc vào locale hệ thống hoặc bạn có thể cache lại locale mà người dùng đã setting và set nó ở đây)
  static final locale = _getLocaleFromLanguage();
  String appLanguage = '';

// fallbackLocale là locale default nếu locale được set không nằm trong những Locale support
  static final fallbackLocale = Locale('en', 'US');

// language code của những locale được support
  static final langCodes = [
    'en',
    'vi',
  ];

// các Locale được support
  static final locales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];


// cái này là Map các language được support đi kèm với mã code của lang đó: cái này dùng để đổ data vào Dropdownbutton và set language mà không cần quan tâm tới language của hệ thống
  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
  });

// function change language nếu bạn không muốn phụ thuộc vào ngôn ngữ hệ thống
  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en,
    'vi_VN': vi,
  };

  static Locale _getLocaleFromLanguage({String langCode}) {
    // final getStore = GetStorage();
    // String lang = await getStore.read('lang') ?? Get.deviceLocale.languageCode;
    var lang = langCode ?? Get.deviceLocale.languageCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) {
        return locales[i];
      }
    }
    return Get.locale;
  }
}