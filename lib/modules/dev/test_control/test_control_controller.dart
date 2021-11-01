import 'package:bccp_mobile_v2/core/form-module/form_module.dart';
import 'package:get/get.dart';

class TestControlController extends GetxController {
  Rx<String> title = 'Dev '.obs;
  final isLoading = false.obs;

  final myForm = FormModule({
    'customer': FormControl<String>(defaultValue: 'kha ne', instantType: ''),
    'age': FormControl<int>(defaultValue: null, instantType: 0),
    'birthDate': FormControl<DateTime>(defaultValue: null, instantType: DateTime.now()),
  });

  final formGroup = FormModule({
    'customer': FormControl<String>(defaultValue: 'customer null', instantType: ''),
    'age': FormControl<int>(defaultValue: null, instantType: 0),
    'birthDate': FormControl<DateTime>(defaultValue: null, instantType: DateTime.now()),
  }).obs;

  RxMap<dynamic, dynamic> formObs = {
    'customer': 'init customer',
    'age': 18,
    'birthDate': null,
  }.obs;

  RxMap<dynamic, dynamic> formObsError = {
    'customer': '',
    'age': '',
    'birthDate': '',
  }.obs;

  Map formObsValidate = {
    'customer': [

    ],
    'age': '',
    'birthDate': '',
  };

  Map formObsType = {
    'customer': '',
    'age': 18,
    'birthDate': DateTime,
  };


  void onInit() async {

    super.onInit();
    await 2.delay();
    // this.formObs['customer'] = 'change roi nha';

    this.formObs.pathValue({
      'customer': 'lllllllllllllon',
      'age': 23,
      'birthDate': DateTime.now()
    }, {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}

extension PathValue on Map {
  void pathValue(Map mapValue,Map mapType) {
    mapValue.forEach((key, value) {
      if(mapType[key] == DateTime) {
        this[key] = DateTime.parse(mapValue[key].toString());
      } else {
        this[key] = mapValue[key];
      }
    });
  }


}