import 'dart:convert';

import 'package:bccp_mobile_v2/data_service/repositories/base_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  static String getDayOfWeek() {
    var date = DateTime.now();
    switch (date.weekday) {
      case DateTime.monday:
        return 'Thứ hai';
      case DateTime.tuesday:
        return 'Thứ ba';
      case DateTime.wednesday:
        return 'Thứ tư';
      case DateTime.thursday:
        return 'Thứ năm';
      case DateTime.friday:
        return 'Thứ sáu';
      case DateTime.saturday:
        return 'Thứ bảy';
      default:
        return 'Chủ nhật';
    }
  }
  static String getDateNow() {
    var date = DateTime.now();
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String listMapToString(List<Map> value) {
    List<String> lst = [];
    value.forEach((element) {
      lst.add(json.encode(element));
    });
    return '[${lst.join(',')}]';
  }

  static String timeGTMToStringFull(DateTime gmtTime) {
    if (gmtTime == null) return '';
    return DateFormat.yMEd().add_jms().format(gmtTime.toLocal());
  }

  static String stringGTMToStringFull(String gmtTime) {
    if (gmtTime == null) return '';
    return DateFormat.yMEd().add_jms().format(DateTime.parse(gmtTime).toLocal());
  }

  static String timeGTMToStringShort(DateTime gmtTime) {
    if (gmtTime == null) return '';
    final DateFormat formatter = DateFormat("dd/MM/yyyy HH:mm:ss");
    return formatter.format(gmtTime.toLocal());
  }

  static String stringGTMToStringShort(String gmtTime) {
    if (gmtTime == null) return '';
    final DateFormat formatter = DateFormat("dd/MM/yyyy");
    return formatter.format(DateTime.parse(gmtTime).toLocal());
  }

  static String getFirstImageString(dynamic image) {
    var jsonArray = [];
    try {
      jsonArray =  (json.decode(image) as List);
    } catch(e) {}
    String imgShow = '';
    if(jsonArray.length > 0) {
      imgShow = jsonArray[0]['fileUrl'].toString().replaceAll('/kt1','').replaceAll('dowload', 'dowloadimage');
      return BaseRepository.baseUrlKt1 + imgShow;
    }
    return '';
  }

  static String requestStatusToStringNormal(int status) {
    switch(status) {
      case 1:
        return 'Đang khởi tạo';
      case 2:
        return 'Chờ bưu tá xác nhận';
      case 3:
        return 'Bưu tá đã xác nhận';
      case 4:
        return 'Bưu tá từ chối nhận';
      case 5:
        return 'Chờ GDV xác nhận';
      case 6:
        return 'GDV đã xác nhận';
      case 7:
        return 'GDV từ chối nhận';
      case 8:
        return 'Đã chấp nhận';
      default:
        return '';
    }
  }

  static String requestStatusToStringSpec(int status) {
    switch(status) {
      case 1:
        return 'Đang khởi tạo';
      case 2:
        return 'Chờ bưu tá xác nhận';
      case 3:
        return 'Bưu tá đã xác nhận';
      case 4:
        return 'Bưu tá từ chối nhận';
      case 5:
        return 'Chờ GDV xác nhận';
      case 6:
        return 'GDV đã xác nhận';
      case 7:
        return 'GDV từ chối nhận';
      case 8:
        return 'Đã tạo vận đơn';
      default:
        return '';
    }
  }

  static String tuyenPhatStatus(int status) {
    switch(status) {
      case 2:
        return 'Đã xác nhận đi phát';
      case 3:
        return 'Đã nhập thông tin phát';
      case 4:
        return 'Đã hoàn thành phát';
      default:
        return '';
    }
  }

  static String trangThaiPhatBuuGui(int status) {
    switch(status) {
      case 0:
        return 'Chưa phát';
      case 1:
        return 'Phát thành công';
      case 2:
        return 'Phát thất bại';
      default:
        return '';
    }
  }

  static Color trangThaiPhatBuuGuiColor(int status) {
    switch (status) {
      case 0:
        return Colors.orangeAccent;
      case 1:
        return Colors.green;
      case 2:
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }
}

