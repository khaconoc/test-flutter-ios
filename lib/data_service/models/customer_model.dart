class CustomerModel {
  String customerAddress;
  String customerCode;
  String customerName;
  String email;
  String fax;
  String identificationNumber;
  String mobile;
  String note;
  String posCode;
  String taxCode;
  String tel;

  CustomerModel(
      {this.customerAddress,
        this.customerCode,
        this.customerName,
        this.email,
        this.fax,
        this.identificationNumber,
        this.mobile,
        this.note,
        this.posCode,
        this.taxCode,
        this.tel});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    customerAddress = json['customerAddress'];
    customerCode = json['customerCode'];
    customerName = json['customerName'];
    email = json['email'];
    fax = json['fax'];
    identificationNumber = json['identificationNumber'];
    mobile = json['mobile'];
    note = json['note'];
    posCode = json['posCode'];
    taxCode = json['taxCode'];
    tel = json['tel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerAddress'] = this.customerAddress;
    data['customerCode'] = this.customerCode;
    data['customerName'] = this.customerName;
    data['email'] = this.email;
    data['fax'] = this.fax;
    data['identificationNumber'] = this.identificationNumber;
    data['mobile'] = this.mobile;
    data['note'] = this.note;
    data['posCode'] = this.posCode;
    data['taxCode'] = this.taxCode;
    data['tel'] = this.tel;
    return data;
  }
}
