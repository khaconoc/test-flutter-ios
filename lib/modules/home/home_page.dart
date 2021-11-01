import 'package:badges/badges.dart';
import 'package:bccp_mobile_v2/core/services/auth_service.dart';
import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/core/utils/util_color.dart';
import 'package:bccp_mobile_v2/modules/home/home_controller.dart';
import 'package:bccp_mobile_v2/modules/home/widgets/weather_widget.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  final AuthService _authService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        leading: Container(
          margin: EdgeInsets.only(left: 0),
          padding: EdgeInsets.all(8),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(60.0)),
            child: Image.asset(
              'assets/images/avata.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(_authService.getUserInfo.fullName),
        actions: [
          // IconButton(
          //   icon: Icon(
          //     Icons.settings,
          //     color: Colors.black54,
          //   ),
          //   onPressed: () {
          //     Get.toNamed(Routes.SETTING);
          //   },
          // ),
          Obx(() => Badge(
            position: BadgePosition.topEnd(top: 10, end: 10),
            showBadge: controller.configServiceService.isHasNerVersion.value,
            badgeContent: null,
            child: IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.black54,
              ),
              onPressed: () {
                Get.toNamed(Routes.NOTIFICATION);
              },
            ),
          ),),
          Obx(() => Badge(
            position: BadgePosition.topEnd(top: 10, end: 10),
            showBadge: controller.configServiceService.isHasNerVersion.value,
            badgeContent: null,
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black54,
              ),
              onPressed: () {
                Get.toNamed(Routes.SETTING);
              },
            ),
          ),),
          // Badge(
          //   position: BadgePosition.topEnd(top: 10, end: 10),
          //   showBadge: controller.configServiceService.isHasNerVersion.value,
          //   badgeContent: null,
          //   child: IconButton(
          //     icon: Icon(
          //       Icons.settings,
          //       color: Colors.black54,
          //     ),
          //     onPressed: () {
          //       Get.toNamed(Routes.SETTING);
          //     },
          //   ),
          // )
          // Obx(
          //   () => IconButton(
          //     icon: Image.asset('assets/images/icon_vi.png'),
          //     onPressed: () {
          //       controller.onChangeLanguage();
          //     },
          //   ),
          // ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.blue.withAlpha(30),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(10),
                  color: mainColor,
                  // border: Border.all(),
                ),
                child: Hero(
                  tag: 'search_box',
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        // border: Border.all(),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.SEARCH);
                              },
                              child: TextField(
                                enabled: false,
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'searchPostage'.tr),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: IconButton(
                              icon: Image.asset('assets/images/icon_scan.png'),
                              onPressed: () async {
                                controller.scanQrCode();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: RefreshIndicator(
                  onRefresh: () async {
                    await new Future.delayed(new Duration(seconds: 3));
                    return;
                  },
                  child: Column(
                    children: [
                      WeatherWidget(),
                      Expanded(
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ItemTapWithTopIcon(
                                            text: 'receive'.tr,
                                            color: [
                                              UtilColor.getColorFromHex('#00aeef'),
                                              UtilColor.getColorFromHex('#00a1ff'),
                                            ],
                                            image: Image.asset(
                                                'assets/images/icon_tiepnhan.png'),
                                            onPress: () {
                                              Get.toNamed(Routes.RECEIVE);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: ItemTapWithTopIcon(
                                            text: 'delivery'.tr,
                                            color: [
                                              // UtilColor.getColorFromHex('#f9ed32'),
                                              UtilColor.getColorFromHex('#fbb040').withAlpha(150),
                                              UtilColor.getColorFromHex('#ef4136'),
                                            ],
                                            image: Image.asset(
                                                'assets/images/icon_shipping.png'),
                                            onPress: () {
                                              Get.toNamed(
                                                Routes.DELIVERY,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ItemTapWithTopIcon(
                                            text: 'receiveSpecial'.tr,
                                            color: [
                                              UtilColor.getColorFromHex('#6a69a8'),
                                              UtilColor.getColorFromHex('#3b3990'),

                                            ],
                                            image: Image.asset(
                                                'assets/images/icon_tiepnhan_dacbiet.png'),
                                            onPress: () {
                                              Get.toNamed(Routes.RECEIVE_SPEC);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: ItemTapWithTopIcon(
                                            text: 'deliverySpecial'.tr,
                                            color: [
                                              // UtilColor.getColorFromHex('#9698d6'),
                                              // UtilColor.getColorFromHex('#797bb8'),
                                              UtilColor.getColorFromHex('#fbb040'),
                                              UtilColor.getColorFromHex('#ef4136'),
                                            ],
                                            image: Image.asset(
                                                'assets/images/icon_delivery_special.png'),
                                            onPress: () {
                                              Get.toNamed(Routes.DELIVERY_SPECIAL);
                                              // DialogService.alert(
                                              //   title: 'Thông báo',
                                              //   message:
                                              //   'Chức năng đang được phát triển',
                                              // );
                                            },
                                            // text: 'setting'.tr,
                                            // color: [
                                            //   UtilColor.getColorFromHex('#6a69a8'),
                                            //   UtilColor.getColorFromHex('#3b3990'),
                                            // ],
                                            // image: Image.asset('assets/images/icon_more.png'),
                                            // onPress: () {
                                            //   Get.toNamed(Routes.SETTING);
                                            //   // Navigator.push(
                                            //   //     context, MaterialPageRoute(builder: (_) => MoreView()));
                                            // },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned.fill(
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      controller.scanQrCode();
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                        border: Border.all(color: Colors.blue.withAlpha(30), width: 15),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Colors.black54.withAlpha(300),
                                        //     blurRadius: 7,
                                        //     spreadRadius: 1,
                                        //     offset: Offset(1,2)
                                        //   )
                                        // ]
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black54.withAlpha(300),
                                                    blurRadius: 7,
                                                    spreadRadius: 1,
                                                    offset: Offset(1,2)
                                                )
                                              ]
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/scan-qr-code-icon.gif',
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemTap extends StatelessWidget {
  final String text;
  final Image image;
  final Function onPress;
  final List<Color> color;

  const ItemTap(
      {Key key,
      @required this.image,
      @required this.onPress,
      @required this.text,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: color,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.orange.withAlpha(100),
                    ),
                child: image,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.green.withAlpha(50),
                    ),
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemTapWithTopIcon extends StatelessWidget {
  final String text;
  final Image image;
  final Function onPress;
  final List<Color> color;

  const ItemTapWithTopIcon(
      {Key key,
      @required this.image,
      @required this.onPress,
      @required this.text,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          // color: color,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: color,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.orange.withAlpha(100),
                    ),
                child: image,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.green.withAlpha(50),
                    ),
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
