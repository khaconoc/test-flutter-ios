import 'package:bccp_mobile_v2/data/model/base_model.dart';

class CustomerModel extends BaseModel<CustomerModel>{
  String customerCode;
  String posCode;
  String customerName;
  String customerAddress;
  String mobile;
  String tel;
  String email;
  String fax;
  String taxCode;
  String identificationNumber;
  String note;

  CustomerModel(
      {this.customerCode,
        this.posCode,
        this.customerName,
        this.customerAddress,
        this.mobile,
        this.tel,
        this.email,
        this.fax,
        this.taxCode,
        this.identificationNumber,
        this.note});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    customerCode = json['customerCode'];
    posCode = json['posCode'];
    customerName = json['customerName'];
    customerAddress = json['customerAddress'];
    mobile = json['mobile'];
    tel = json['tel'];
    email = json['email'];
    fax = json['fax'];
    taxCode = json['taxCode'];
    identificationNumber = json['identificationNumber'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerCode'] = this.customerCode;
    data['posCode'] = this.posCode;
    data['customerName'] = this.customerName;
    data['customerAddress'] = this.customerAddress;
    data['mobile'] = this.mobile;
    data['tel'] = this.tel;
    data['email'] = this.email;
    data['fax'] = this.fax;
    data['taxCode'] = this.taxCode;
    data['identificationNumber'] = this.identificationNumber;
    data['note'] = this.note;
    return data;
  }

  @override
  CustomerModel fromJson(json) {
    return CustomerModel.fromJson(json);
  }
}
