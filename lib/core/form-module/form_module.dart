class FormModule {
  Map<String, FormControl> value;

  FormModule(Map<String, FormControl> value1) {
    this.value = value1;
  }

  Map getRawValue() {
    Map<String, dynamic> tempValue = {};
    value.forEach((k,v) {
      tempValue[k] = v.value;
    });
    return tempValue;
  }

  Map getRawError() {
    Map<String, dynamic> tempValue = {};
    value.forEach((k,v) {
      tempValue[k] = v.error;
    });
    return tempValue;
  }

  void pathValue(Map<String, dynamic> value) {
    for(var e in value.entries) {
      print('type ${e.key}: ${this.value[e.key].instantType.runtimeType}');
      if(this.value[e.key].instantType is DateTime) {
        this.value[e.key].value = DateTime.parse(e.value.toString());
        continue;
      }
      this.value[e.key].value = e.value;
    }

  }

  void disabled() {
    for(var e in this.value.entries) {
      this.value[e.key].disable = true;
    }
  }

  FormControl get(String control) {
    return value[control];
  }

  bool inValid() {
    List<bool> flagValidator = [];
    for(var e in value.entries) {
      if(e.value.validator.isNotEmpty) {

        List<Validator> lstValidation = e.value.validator;
        lstValidation.forEach((func) {
          ResultValidate rs = func.myFunction(
            value: e.value.value,
            valueValidate: func.value,
            message: func.message,
          );
          flagValidator.add(rs.value);
          // print('validate control)))))))))))))))): ${e.key}: ${rs.value}');
          if(rs.value) {
            e.value.error = '';
          } else {
            e.value.error = rs.message;
          }
        });
      }
    }
    bool re = flagValidator.firstWhere((e) => e == false, orElse: () => true);
    return re;
  }


}

class FormControl<T> {
  T value;
  T instantType;
  String error = '';
  bool disable = false;
  List<Validator> validator;

  FormControl({T defaultValue, List<Validator> validator,T instantType}) {
    this.value = defaultValue;
    this.instantType = instantType;
    this.validator = validator == null ? [] : validator;
  }

  void setValue(T value) {
    this.value = value;
  }
}

class FormValidation {
  bool validator() {
    return true;
  }

  static ResultValidate combineValidate(bool rs, String message) {
    return ResultValidate(rs, rs ? '' : message);
  }

  static ResultValidate required({dynamic value, dynamic valueValidate, String message}) {
    if(message == null) {
      message = 'Không được bỏ trống';
    }
    bool rs = value != null && value != '';
    return combineValidate(rs, message);
  }

  static ResultValidate maxLength({dynamic value, dynamic valueValidate, String message}) {
    if(message == null) {
      message = 'Không được quá $valueValidate kí tự';
    }
    bool rs = value.toString().length <= valueValidate;
    return combineValidate(rs, message);
  }

  static ResultValidate minLength({dynamic value, dynamic valueValidate, String message}) {
    if(message == null) {
      message = 'Phải từ $valueValidate kí tự trở lên';
    }
    bool rs = value.toString().length >= valueValidate;
    return combineValidate(rs, message);
  }

}

class ResultValidate {
  bool value;
  String message;
  ResultValidate(bool value, String message) {
    this.value = value;
    this.message = message;
  }
}

class Validator {
  String message;
  dynamic value;
  ResultValidate Function({dynamic value, dynamic valueValidate, String message}) myFunction;
  Validator({ResultValidate Function({dynamic value, dynamic valueValidate, String message}) validate, String message, dynamic valueValidate}) {
    this.message = message;
    this.myFunction = validate;
    this.value = valueValidate;
  }
}