class NotificationModel {
  int id;
  String title;
  String time;
  String message;
  bool seen;

  NotificationModel({this.id, this.title, this.time, this.message, this.seen});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    time = json['time'];
    message = json['message'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['time'] = this.time;
    data['message'] = this.message;
    data['seen'] = this.seen;
    return data;
  }
}
