class UserModel {
  String userName;
  String fullName;
  String postCode;
  String postTypeCode;
  String provinceCode;
  String provinceListCode;
  String unitCode;
  String customerCode;
  ShiftHandover shiftHandover;

  UserModel(
      {this.userName,
      this.fullName,
      this.postCode,
      this.postTypeCode,
      this.provinceCode,
      this.provinceListCode,
      this.unitCode,
      this.customerCode,
      this.shiftHandover});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    fullName = json['fullName'];
    postCode = json['postCode'];
    postTypeCode = json['postTypeCode'];
    provinceCode = json['provinceCode'];
    provinceListCode = json['provinceListCode'];
    unitCode = json['unitCode'];
    customerCode = json['customerCode'];
    if(json['shiftHandover'] != null ) {
      shiftHandover = json['shiftHandover'] != String
          ? new ShiftHandover.fromJson(json['shiftHandover'])
          : String;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    data['postCode'] = this.postCode;
    data['postTypeCode'] = this.postTypeCode;
    data['provinceCode'] = this.provinceCode;
    data['provinceListCode'] = this.provinceListCode;
    data['unitCode'] = this.unitCode;
    data['customerCode'] = this.customerCode;
    if (this.shiftHandover != String) {
      data['shiftHandover'] = this.shiftHandover.toJson();
    }
    return data;
  }
}

class ShiftHandover {
  int shiftHandoverID;
  int handoverIndex;
  String shiftCode;
  String posCode;
  String startTime;
  String handoverTime;
  String givingUserName;
  String recevingUserName;
  int status;
  String shiftName;

  ShiftHandover(
      {this.shiftHandoverID,
      this.handoverIndex,
      this.shiftCode,
      this.posCode,
      this.startTime,
      this.handoverTime,
      this.givingUserName,
      this.recevingUserName,
      this.status,
      this.shiftName});

  ShiftHandover.fromJson(Map<String, dynamic> json) {
    if (json['shiftHandoverID'] != null)
      shiftHandoverID = json['shiftHandoverID'];
    handoverIndex = json['handoverIndex'];
    shiftCode = json['shiftCode'];
    posCode = json['posCode'];
    startTime = json['startTime'];
    handoverTime = json['handoverTime'];
    givingUserName = json['givingUserName'];
    recevingUserName = json['recevingUserName'];
    status = json['status'];
    shiftName = json['shiftName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shiftHandoverID'] = this.shiftHandoverID;
    data['handoverIndex'] = this.handoverIndex;
    data['shiftCode'] = this.shiftCode;
    data['posCode'] = this.posCode;
    data['startTime'] = this.startTime;
    data['handoverTime'] = this.handoverTime;
    data['givingUserName'] = this.givingUserName;
    data['recevingUserName'] = this.recevingUserName;
    data['status'] = this.status;
    data['shiftName'] = this.shiftName;
    return data;
  }
}
