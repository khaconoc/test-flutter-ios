import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;

abstract class BaseRepository {

  static Map env = appEnv;
  /// app
  static String baseUrl = env['baseUrl'];
  static String baseUrlNew = env['baseUrlNew'];
  static String _baseUrlSSO = env['baseUrlSSO'];
  ///dev
  // static String baseUrl = 'https://vnpost.ddns.net/kt1';
  // static String baseUrlNew = 'https://vnpost.ddns.net/mobile';
  // static String _baseUrlSSO = 'https://vnpost.ddns.net/sso';

  ///poc
  // static String baseUrl = 'https://vnpost.ddns.net/poc/kt1';
  // static String baseUrlNew = 'https://vnpost.ddns.net/poc/mobile';
  // static String _baseUrlSSO = 'https://vnpost.ddns.net/poc/sso';

  /// link deploy product
  // static String baseUrl = 'http://45.252.243.4/mobile-api-gate-way';
  // static String _baseUrlSSO = 'http://45.252.243.4/mobile-api-gate-way/sso';

  static String loginApi = '$_baseUrlSSO/connect/token';
  static String userInfoApi = '$baseUrl/api/User/GetUserInfo';
  static String dimPagingApi = '$baseUrl/api/DimFile/GetPaging';

  /// get paging search
  static String getSearchPaging = '$baseUrlNew/api/extend/qrcode/GetPaging';

  /// get paging tiep nhan thuong
  static String getRequestAcceptedPaging = '$baseUrlNew/api/tiepnhan/TiepNhanThuong/RequestGetPaging';

  /// get paging tiep nhan dat biet
  static String getPagingTiepNhanDatBiet = '$baseUrlNew/api/tiepnhan/TiepNhanDacBiet/RequestGetPaging';

  /// get paging phat thuong
  static String getPagingDanhSachTuyenPhat = '$baseUrlNew/api/phat/PhatThuong/MailtripDeliveryGetPaging';
  ///---- get paging buu gui trong tuyen phat
  static String getPagingBuuGuiTrongTuyenPhat = '$baseUrlNew/api/phat/PhatThuong/MailtripItemGetPaging';

  /// get paging phat dac biet
  static String getPagingBuuGuiPhatDacBiet = '$baseUrlNew/api/phat/PhatDacBiet/MailtripItemGetPaging';

  /// phat dac biet
  static String getListPackagePaging = '$baseUrl/api/Item/GetPagingByAcceptanceCode';
  /// tiếp nhận
  static String tiepNhanRequestAcceptedPaging = '$baseUrl/api/RequestAccepted/GetPaging';

  static String getCustomerCombobox = '$baseUrl/api/Customer/GetCombobox';
  static String getPosCombobox = '$baseUrl/api/POS/GetCombobox';
  static String getCustomerObjectCombobox = '$baseUrl/api/CustomerObject/GetCombobox';
  static String getItemTypeCombobox = '$baseUrl/api/ItemType/GetCombobox';
  static String getDeliveryPointCustomerCombobox = '$baseUrl/api/DimDeliveryPoint/GetComboboxCustomer';
  static String getNguoiThucNhanCombobox = '$baseUrl/api/PhatDeliveryPointReceiver/GetCombobox';
  static String getProvinceCombobox = '$baseUrl/api/Province/GetCombobox';
  static String getDistrictCombox = '$baseUrl/api/District/GetCombobox';
  static String getCommuneCombobox = '$baseUrl/api/Commune/GetCombobox';
  static String getLyDoKhongPhatDuocComBobox = '$baseUrl/api/PhatCause/GetCombobox';

  /// upload file api
  static String postFileApi = '$baseUrl/api/File/Upload';

  static String getWeatherApi = 'https://api.openweathermap.org/data/2.5/weather';
}