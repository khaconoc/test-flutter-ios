part of './pages.dart';

abstract class Routes {
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const SETTING = '/setting';
  static const RECEIVE = '/receive';
  static const RECEIVE_REQUEST_DETAIL = '/receive_request_detail';
  static const RECEIVE_PACKAGE_CRUD = '/receive_package_crud';

  static const RECEIVE_SPEC = '/receive_spec';
  static const RECEIVE_SPEC_REQUEST_DETAIL = '/receive_spec_request_detail';
  static const RECEIVE_SPEC_PACKAGE_CRUD = '/receive_spec_package_crud';

  static const DELIVERY_SPECIAL = '/delivery_special';
  static const DELIVERY_SPEC_SEND_ONE = '/delivery_spec_send_one';
  static const DELIVERY_SPEC_SEND_MORE = '/delivery_spec_send_more';
  static const SEARCH = '/search';

  static const DELIVERY = '/delivery';
  static const DELIVERY_DETAIL = '/delivery_detail';
  static const DELIVERY_SEND_ONE = '/delivery_send_one';
  static const DELIVERY_SEND_MORE = '/delivery_send_more';

  static const POSTAGE = '/postage';
  static const DIRECT = '/direct';
  static const NOTIFICATION = '/notification';
  static const NOTIFICATION_DETAIL = '/notification_detail';
  static const APP_COMBO_BOX_NETWORK = '/app_combo_box_network';
  static const TEST_CONTROL = '/test_control';
  static const RECEIVER_REAL_ADD = '/receiver_real_add';
  static const DELIVERY_HISTORY = '/delivery_history';
  static const WEB_VIEW_CUSTOM = '/web_view_custom';
  // static const RECEIVE_SPACIAL_PACKAGE_CRUD = '/receive_spacial_package_crud';
}