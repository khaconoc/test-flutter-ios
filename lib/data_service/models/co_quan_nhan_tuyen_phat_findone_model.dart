class CoQuanNhanTuyenPhatFindOneModel {
  Id id;
  String deliveryPointName;
  String deliveryPointAddress;
  String provinceCode;
  String districtCode;
  String communeCode;
  String posCode;
  String lat;
  String long;
  String customerName;
  List<DeliveryRoutePoint> deliveryRoutePoint;

  CoQuanNhanTuyenPhatFindOneModel(
      {this.id,
        this.deliveryPointName,
        this.deliveryPointAddress,
        this.provinceCode,
        this.districtCode,
        this.communeCode,
        this.posCode,
        this.lat,
        this.long,
        this.customerName,
        this.deliveryRoutePoint});

  CoQuanNhanTuyenPhatFindOneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    deliveryPointName = json['deliveryPointName'];
    deliveryPointAddress = json['deliveryPointAddress'];
    provinceCode = json['provinceCode'];
    districtCode = json['districtCode'];
    communeCode = json['communeCode'];
    posCode = json['posCode'];
    lat = json['lat'] != null ? json['lat'].toString() : '';
    long = json['long'] != null ? json['long'].toString() : '';
    customerName = json['customerName'];
    if (json['deliveryRoutePoint'] != null) {
      deliveryRoutePoint = new List<DeliveryRoutePoint>();
      json['deliveryRoutePoint'].forEach((v) {
        deliveryRoutePoint.add(new DeliveryRoutePoint.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id.toJson();
    }
    data['deliveryPointName'] = this.deliveryPointName;
    data['deliveryPointAddress'] = this.deliveryPointAddress;
    data['provinceCode'] = this.provinceCode;
    data['districtCode'] = this.districtCode;
    data['communeCode'] = this.communeCode;
    data['posCode'] = this.posCode;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['customerName'] = this.customerName;
    if (this.deliveryRoutePoint != null) {
      data['deliveryRoutePoint'] =
          this.deliveryRoutePoint.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Id {
  String deliveryPointCode;
  String customerCode;

  Id({this.deliveryPointCode, this.customerCode});

  Id.fromJson(Map<String, dynamic> json) {
    deliveryPointCode = json['deliveryPointCode'];
    customerCode = json['customerCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deliveryPointCode'] = this.deliveryPointCode;
    data['customerCode'] = this.customerCode;
    return data;
  }
}

class DeliveryRoutePoint {
  String deliveryRouteCode;
  String fromPOSCode;

  DeliveryRoutePoint({this.deliveryRouteCode, this.fromPOSCode});

  DeliveryRoutePoint.fromJson(Map<String, dynamic> json) {
    deliveryRouteCode = json['deliveryRouteCode'];
    fromPOSCode = json['fromPOSCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deliveryRouteCode'] = this.deliveryRouteCode;
    data['fromPOSCode'] = this.fromPOSCode;
    return data;
  }
}
