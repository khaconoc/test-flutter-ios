import 'package:bccp_mobile_v2/module_share/delivery_history/delivery_history_binding.dart';
import 'package:bccp_mobile_v2/module_share/delivery_history/delivery_history_page.dart';
import 'package:bccp_mobile_v2/module_share/receiver_real_add/receiver_real_add_binding.dart';
import 'package:bccp_mobile_v2/module_share/receiver_real_add/receiver_real_add_page.dart';
import 'package:bccp_mobile_v2/module_share/web_view_custom/web_view_custom_binding.dart';
import 'package:bccp_mobile_v2/module_share/web_view_custom/web_view_custom_page.dart';
import 'package:bccp_mobile_v2/modules/delivery/delivery_binding.dart';
import 'package:bccp_mobile_v2/modules/delivery/delivery_detail/delivery_detail_binding.dart';
import 'package:bccp_mobile_v2/modules/delivery/delivery_detail/delivery_detail_page.dart';
import 'package:bccp_mobile_v2/modules/delivery/delivery_page.dart';
import 'package:bccp_mobile_v2/modules/delivery/delivery_send_more/delivery_send_more_binding.dart';
import 'package:bccp_mobile_v2/modules/delivery/delivery_send_more/delivery_send_more_page.dart';
import 'package:bccp_mobile_v2/modules/delivery/delivery_send_one/delivery_send_one_binding.dart';
import 'package:bccp_mobile_v2/modules/delivery/delivery_send_one/delivery_send_one_page.dart';
import 'package:bccp_mobile_v2/modules/delivery_spec/delivery_spec_binding.dart';
import 'package:bccp_mobile_v2/modules/delivery_spec/delivery_spec_page.dart';
import 'package:bccp_mobile_v2/modules/delivery_spec/delivery_spec_send_more/delivery_spec_send_more_binding.dart';
import 'package:bccp_mobile_v2/modules/delivery_spec/delivery_spec_send_more/delivery_spec_send_more_page.dart';
import 'package:bccp_mobile_v2/modules/delivery_spec/delivery_spec_send_one/delivery_spec_send_one_binding.dart';
import 'package:bccp_mobile_v2/modules/delivery_spec/delivery_spec_send_one/delivery_spec_send_one_page.dart';
import 'package:bccp_mobile_v2/modules/dev/test_control/test_control_binding.dart';
import 'package:bccp_mobile_v2/modules/dev/test_control/test_control_page.dart';
import 'package:bccp_mobile_v2/modules/home/home_binding.dart';
import 'package:bccp_mobile_v2/modules/home/home_page.dart';
import 'package:bccp_mobile_v2/modules/login/login_binding.dart';
import 'package:bccp_mobile_v2/modules/login/login_page.dart';
import 'package:bccp_mobile_v2/modules/notification/notification_binding.dart';
import 'package:bccp_mobile_v2/modules/notification/notification_detail/notification_detail_binding.dart';
import 'package:bccp_mobile_v2/modules/notification/notification_detail/notification_detail_page.dart';
import 'package:bccp_mobile_v2/modules/notification/notification_page.dart';
import 'package:bccp_mobile_v2/modules/receive/receive_binding.dart';
import 'package:bccp_mobile_v2/modules/receive/receive_package_crud/receive_package_crud_binding.dart';
import 'package:bccp_mobile_v2/modules/receive/receive_package_crud/receive_package_crud_page.dart';
import 'package:bccp_mobile_v2/modules/receive/receive_page.dart';
import 'package:bccp_mobile_v2/modules/receive/receive_request_detail/receive_request_detail_binding.dart';
import 'package:bccp_mobile_v2/modules/receive/receive_request_detail/receive_request_detail_page.dart';
import 'package:bccp_mobile_v2/modules/receive_spec/receive_spec_binding.dart';
import 'package:bccp_mobile_v2/modules/receive_spec/receive_spec_package_crud/receive_spec_package_crud_binding.dart';
import 'package:bccp_mobile_v2/modules/receive_spec/receive_spec_package_crud/receive_spec_package_crud_page.dart';
import 'package:bccp_mobile_v2/modules/receive_spec/receive_spec_page.dart';
import 'package:bccp_mobile_v2/modules/receive_spec/receive_spec_request_detail/receive_spec_request_detail_binding.dart';
import 'package:bccp_mobile_v2/modules/receive_spec/receive_spec_request_detail/receive_spec_request_detail_page.dart';
import 'package:bccp_mobile_v2/modules/search/search_binding.dart';
import 'package:bccp_mobile_v2/modules/search/search_page.dart';
import 'package:bccp_mobile_v2/modules/setting/setting_binding.dart';
import 'package:bccp_mobile_v2/modules/setting/setting_page.dart';
import 'package:bccp_mobile_v2/modules/splash/splash_binding.dart';
import 'package:bccp_mobile_v2/modules/splash/splash_page.dart';
import 'package:get/get.dart';

part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SETTING,
      page: () => SettingPage(),
      binding: SettingBinding(),
      // transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.DELIVERY,
      page: () => DeliveryPage(),
      binding: DeliveryBinding(),
      // transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.DELIVERY_DETAIL,
      page: () => DeliveryDetailPage(),
      binding: DeliveryDetailBinding(),
    ),
    GetPage(
      name: Routes.DELIVERY_SEND_ONE,
      page: () => DeliverySendOnePage(),
      binding: DeliverySendOneBinding(),
    ),
    GetPage(
      name: Routes.DELIVERY_SEND_MORE,
      page: () => DeliverySendMorePage(),
      binding: DeliverySendMoreBinding(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchPage(),
      binding: SearchBinding(),
      transition: Transition.downToUp,
    ),

    /// tiếp nhận thường
    GetPage(
      name: Routes.RECEIVE,
      page: () => ReceivePage(),
      binding: ReceiveBinding(),
      // transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.RECEIVE_REQUEST_DETAIL,
      page: () => ReceiveRequestDetailPage(),
      binding: ReceiveRequestDetailBinding(),
      // transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.RECEIVE_PACKAGE_CRUD,
      page: () => ReceivePackageCrudPage(),
      binding: ReceivePackageCrudBinding(),
    ),

    /// tiếp nhận đặc biệt
    GetPage(
      name: Routes.RECEIVE_SPEC,
      page: () => ReceiveSpecPage(),
      binding: ReceiveSpecBinding(),
      // transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.RECEIVE_SPEC_REQUEST_DETAIL,
      page: () => ReceiveSpecRequestDetailPage(),
      binding: ReceiveSpecRequestDetailBinding(),
      // transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.RECEIVE_SPEC_PACKAGE_CRUD,
      page: () => ReceiveSpecPackageCrudPage(),
      binding: ReceiveSpecPackageCrudBinding(),
    ),

    ///
    GetPage(
      name: Routes.DELIVERY_SPECIAL,
      page: () => DeliverySpecPage(),
      binding: DeliverySpecBinding(),
    ),
    GetPage(
      name: Routes.DELIVERY_SPEC_SEND_ONE,
      page: () => DeliverySpecSendOnePage(),
      binding: DeliverySpecSendOneBinding(),
    ),
    GetPage(
      name: Routes.DELIVERY_SPEC_SEND_MORE,
      page: () => DeliverySpecSendMorePage(),
      binding: DeliverySpecSendMoreBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => NotificationPage(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION_DETAIL,
      page: () => NotificationDetailPage(),
      binding: NotificationDetailBinding(),
    ),
    GetPage(
      name: Routes.TEST_CONTROL,
      page: () => TestControlPage(),
      binding: TestControlBinding(),
    ),
    GetPage(
      name: Routes.RECEIVER_REAL_ADD,
      page: () => ReceiverRealAddPage(),
      binding: ReceiverRealAddBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.DELIVERY_HISTORY,
      page: () => DeliveryHistoryPage(),
      binding: DeliveryHistoryBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.WEB_VIEW_CUSTOM,
      page: () => WebViewCustomPage(),
      binding: WebViewCustomBinding(),
      transition: Transition.downToUp,
    ),
  ];
}
