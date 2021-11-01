import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class DialogService {
  // static Future<bool> confirm({String title = 'Thông báo', String message = ''}) async {
  //   bool confirm = false;
  //
  //   void onAccept() {
  //     confirm = true;
  //     Get.back(); // đóng popup
  //   }
  //
  //   void onCancel() {
  //     Get.back(); // đóng popup
  //   }
  //
  //   await showDialog(
  //       barrierDismissible: false,
  //       context: Get.context,
  //       builder: (context) {
  //         return Scaffold(
  //           backgroundColor: Colors.transparent,
  //           body: Center(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   // color: Colors.yellow.withAlpha(100),
  //                   width: MediaQuery.of(context).size.width - 30,
  //                   // height: 200,
  //                   child: Column(
  //                     children: [
  //                       Container(
  //                         // width: MediaQuery.of(context).size.width,
  //                         child: Align(
  //                           child: Text(
  //                             title,
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 20,
  //                             ),
  //                           ),
  //                           alignment: Alignment.center,
  //                         ),
  //                         decoration: new BoxDecoration(
  //                             borderRadius: BorderRadius.only(
  //                               topLeft: Radius.circular(10),
  //                               topRight: Radius.circular(10),
  //                             ),
  //                             // color: mainColor,
  //                             gradient: LinearGradient(
  //                               begin: Alignment.topRight,
  //                               end: Alignment.bottomLeft,
  //                               colors: BccpAppTheme.dialogTheme_primary,
  //                             )
  //                         ),
  //                         padding: EdgeInsets.all(5.0),
  //                       ),
  //                       Container(
  //                         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
  //                         child: Center(
  //                           child: Text(
  //                             message,
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                               color: Colors.blueGrey,
  //                               fontSize: 16,
  //                             ),
  //                           ),
  //                         ),
  //                         decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           border: Border(
  //                             bottom: BorderSide(
  //                               width: 0.5,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         height: 40,
  //                         child: Row(
  //                           crossAxisAlignment: CrossAxisAlignment.stretch,
  //                           children: [
  //                             Expanded(
  //                               child: Container(
  //                                 child: ElevatedButton(
  //                                   style: ButtonStyle(
  //                                     elevation: MaterialStateProperty.all<double>(0.0),
  //                                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                                       RoundedRectangleBorder(
  //                                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
  //                                         // side: BorderSide(color: Colors.red)
  //                                       ),
  //                                     ),
  //                                     backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  //                                     overlayColor: MaterialStateProperty.all<Color>(Colors.grey.withAlpha(10)),
  //                                   ),
  //                                   onPressed: () {
  //                                     onCancel();
  //                                   },
  //                                   child: Text(
  //                                     "Hủy",
  //                                     style: TextStyle(
  //                                       fontSize: 14.0,
  //                                       color: Colors.grey
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             VerticalDivider(
  //                               width: 0.5,
  //                               color: Colors.grey,
  //                             ),
  //                             Expanded(
  //                               child: Container(
  //                                 child: ElevatedButton(
  //                                   style: ButtonStyle(
  //                                     elevation: MaterialStateProperty.all<double>(0.0),
  //                                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                                       RoundedRectangleBorder(
  //                                         borderRadius: BorderRadius.only(bottomRight: Radius.circular(5)),
  //                                         // side: BorderSide(color: Colors.red)
  //                                       ),
  //                                     ),
  //                                     backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  //                                     overlayColor: MaterialStateProperty.all<Color>(Colors.orangeAccent.withAlpha(10)),
  //                                   ),
  //                                   onPressed: () {
  //                                     onAccept();
  //                                   },
  //                                   child: Text(
  //                                     "Đồng ý",
  //                                     style: TextStyle(
  //                                       fontSize: 14.0,
  //                                         color: Colors.orangeAccent
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  //
  //   return confirm;
  // }

  static Future<bool> confirm(
      {String title = 'Thông báo', String message = ''}) async {
    bool confirm = false;

    void onAccept() {
      confirm = true;
      Get.back(); // đóng popup
    }

    void onCancel() {
      Get.back(); // đóng popup
    }

    await showDialog(
        barrierDismissible: false,
        context: Get.context,
        builder: (context) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Container(
                            child: Container(
                              margin: EdgeInsets.only(top: 40),
                              padding: EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width - 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(minHeight: 100),
                                    child: Center(
                                      child: Text(
                                        message,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomButton(
                                          text: 'Đóng',
                                          borderRadius: 50,
                                          backgroundGradient: BccpAppTheme
                                              .buttonTheme_disabledGradient,
                                          onPress: () {
                                            onCancel();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomButton(
                                          text: 'Đồng ý',
                                          borderRadius: 50,
                                          onPress: () {
                                            onAccept();
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 5, color: mainColor)),
                                    child: Center(
                                      child: Icon(
                                        LineIcons.question,
                                        size: 50,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        });

    return confirm;
  }

  // static Future<bool> alert(
  //     {String title = 'Thông báo',
  //     String message = '',
  //     String textButton = 'Đóng'}) async {
  //   if (message == '' || message == null) {
  //     return false;
  //   }
  //   bool close = false;
  //
  //   void onClose() {
  //     close = true;
  //     Get.back(); // đóng popup
  //   }
  //
  //   await showDialog(
  //       barrierDismissible: false,
  //       context: Get.context,
  //       builder: (context) {
  //         return Scaffold(
  //           backgroundColor: Colors.transparent,
  //           body: Center(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   // color: Colors.yellow.withAlpha(100),
  //                   width: MediaQuery.of(context).size.width - 30,
  //                   // height: 200,
  //                   child: Column(
  //                     children: [
  //                       Container(
  //                         // width: MediaQuery.of(context).size.width,
  //                         child: Align(
  //                           child: Text(
  //                             title,
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 20,
  //                             ),
  //                           ),
  //                           alignment: Alignment.center,
  //                         ),
  //                         decoration: new BoxDecoration(
  //                             borderRadius: BorderRadius.only(
  //                               topLeft: Radius.circular(10),
  //                               topRight: Radius.circular(10),
  //                             ),
  //                             // color: mainColor,
  //                             gradient: LinearGradient(
  //                               begin: Alignment.topRight,
  //                               end: Alignment.bottomLeft,
  //                               colors: BccpAppTheme.dialogTheme_primary,
  //                             )),
  //                         padding: EdgeInsets.all(5.0),
  //                       ),
  //                       Container(
  //                         padding:
  //                             EdgeInsets.symmetric(vertical: 20, horizontal: 5),
  //                         child: Center(
  //                           child: Text(
  //                             message,
  //                             textAlign: TextAlign.center,
  //                           ),
  //                         ),
  //                         decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           border: Border(
  //                             bottom:
  //                                 BorderSide(width: 0.3, color: Colors.grey),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         height: 40,
  //                         child: Row(
  //                           crossAxisAlignment: CrossAxisAlignment.stretch,
  //                           children: [
  //                             Expanded(
  //                               child: Container(
  //                                 child: ElevatedButton(
  //                                   // padding: EdgeInsets.all(8.0),
  //                                   style: ButtonStyle(
  //                                     elevation:
  //                                         MaterialStateProperty.all<double>(
  //                                             0.0),
  //                                     shape: MaterialStateProperty.all<
  //                                         RoundedRectangleBorder>(
  //                                       RoundedRectangleBorder(
  //                                         borderRadius: BorderRadius.vertical(
  //                                             bottom: Radius.circular(5)),
  //                                         // side: BorderSide(color: Colors.red)
  //                                       ),
  //                                     ),
  //                                     backgroundColor:
  //                                         MaterialStateProperty.all<Color>(
  //                                             Colors.white),
  //                                     overlayColor:
  //                                         MaterialStateProperty.all<Color>(
  //                                             Colors.grey.withAlpha(10)),
  //                                   ),
  //                                   onPressed: () {
  //                                     onClose();
  //                                   },
  //                                   child: Text(
  //                                     "Đóng",
  //                                     style: TextStyle(
  //                                         fontSize: 14.0, color: Colors.grey),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  //   return close;
  // }

  static Future<bool> alert(
      {String title = 'Thông báo',
        String message = '',
        String textButton = 'Đóng'}) async {
    if (message == '' || message == null) {
      return false;
    }
    bool close = false;

    void onClose() {
      close = true;
      Get.back(); // đóng popup
    }

    await showDialog(
        barrierDismissible: false,
        context: Get.context,
        builder: (context) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Container(
                            child: Container(
                              margin: EdgeInsets.only(top: 40),
                              padding: EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width - 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(minHeight: 100),
                                    child: Center(
                                      child: Text(
                                        message,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: CustomButton(
                                          text: 'Đóng',
                                          borderRadius: 50,
                                          onPress: () {
                                            onClose();
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 5, color: mainColor)),
                                    child: Center(
                                      child: Icon(
                                        LineIcons.smile_o,
                                        size: 50,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        });
    return close;
  }

  // static Future<bool> error(
  //     {String title = 'Thông báo',
  //     String message = '',
  //     String textButton = 'Đóng'}) async {
  //   if (message == '' || message == null) {
  //     return false;
  //   }
  //   bool close = false;
  //
  //   void onClose() {
  //     close = true;
  //     Get.back(); // đóng popup
  //   }
  //
  //   await showDialog(
  //       barrierDismissible: false,
  //       context: Get.context,
  //       builder: (context) {
  //         return Scaffold(
  //           backgroundColor: Colors.transparent,
  //           body: Center(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   // color: Colors.yellow.withAlpha(100),
  //                   width: MediaQuery.of(context).size.width - 30,
  //                   // height: 200,
  //                   child: Column(
  //                     children: [
  //                       Container(
  //                         // width: MediaQuery.of(context).size.width,
  //                         child: Align(
  //                           child: Text(
  //                             title,
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 20,
  //                             ),
  //                           ),
  //                           alignment: Alignment.center,
  //                         ),
  //                         decoration: new BoxDecoration(
  //                             borderRadius: BorderRadius.only(
  //                               topLeft: Radius.circular(10),
  //                               topRight: Radius.circular(10),
  //                             ),
  //                             // color: mainColor,
  //                             gradient: LinearGradient(
  //                               begin: Alignment.topRight,
  //                               end: Alignment.bottomLeft,
  //                               colors: BccpAppTheme.dialogTheme_danger,
  //                             )),
  //                         padding: EdgeInsets.all(5.0),
  //                       ),
  //                       Container(
  //                         padding:
  //                             EdgeInsets.symmetric(vertical: 20, horizontal: 5),
  //                         child: Center(
  //                           child: Text(
  //                             message,
  //                             textAlign: TextAlign.center,
  //                           ),
  //                         ),
  //                         decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           border: Border(
  //                             bottom:
  //                                 BorderSide(width: 0.3, color: Colors.grey),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         height: 40,
  //                         child: Row(
  //                           crossAxisAlignment: CrossAxisAlignment.stretch,
  //                           children: [
  //                             Expanded(
  //                               child: Container(
  //                                 child: ElevatedButton(
  //                                   // padding: EdgeInsets.all(8.0),
  //                                   style: ButtonStyle(
  //                                     elevation:
  //                                         MaterialStateProperty.all<double>(
  //                                             0.0),
  //                                     shape: MaterialStateProperty.all<
  //                                         RoundedRectangleBorder>(
  //                                       RoundedRectangleBorder(
  //                                         borderRadius: BorderRadius.vertical(
  //                                             bottom: Radius.circular(5)),
  //                                         // side: BorderSide(color: Colors.red)
  //                                       ),
  //                                     ),
  //                                     backgroundColor:
  //                                         MaterialStateProperty.all<Color>(
  //                                             Colors.white),
  //                                     overlayColor:
  //                                         MaterialStateProperty.all<Color>(
  //                                             Colors.grey.withAlpha(10)),
  //                                   ),
  //                                   onPressed: () {
  //                                     onClose();
  //                                   },
  //                                   child: Text(
  //                                     "Đóng",
  //                                     style: TextStyle(
  //                                         fontSize: 14.0, color: Colors.grey),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  //   return close;
  // }

  static Future<bool> error(
      {String title = 'Thông báo',
        String message = '',
        String textButton = 'Đóng'}) async {
    if (message == '' || message == null) {
      return false;
    }
    bool close = false;

    void onClose() {
      close = true;
      Get.back(); // đóng popup
    }

    await showDialog(
        barrierDismissible: false,
        context: Get.context,
        builder: (context) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Container(
                            child: Container(
                              margin: EdgeInsets.only(top: 40),
                              padding: EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width - 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(minHeight: 100),
                                    child: Center(
                                      child: Text(
                                        message,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: CustomButton(
                                          text: 'Đóng',
                                          borderRadius: 50,
                                          onPress: () {
                                            onClose();
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 5, color: Colors.deepOrangeAccent)),
                                    child: Center(
                                      child: Icon(
                                        LineIcons.frown_o,
                                        size: 50,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        });
    return close;
  }

  static void showSnackBar(String text, StatusSnackBar status) {
    Color color;
    switch (status) {
      case StatusSnackBar.success:
        color = kSuccessColor;
        break;
      case StatusSnackBar.error:
        color = kErrorColor;
        break;
      case StatusSnackBar.waring:
        color = kWarningColor;
        break;
      case StatusSnackBar.info:
        color = kInfoColor;
        break;
      default:
        color = kDisabledColor;
        break;
    }
    ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: color,
      duration: Duration(milliseconds: 1500),
    ));
  }

  static void showBottomSheet({List<Widget> children}) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15.0),
            topRight: const Radius.circular(15.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              width: 100,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            // children.toList(),
            for (var item in children) item,
          ],
        ),
      ),
      // backgroundColor: mainColor,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     topLeft: const Radius.circular(15.0),
      //     topRight: const Radius.circular(15.0),
      //   ),
      // ),
      ignoreSafeArea: false,
      // persistent: false
      isScrollControlled: true,
    );
  }

  static void onShowLoading(bool isShow) {
    if (isShow) {
      showDialog(
        context: Get.overlayContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: SpinKitSpinningLines(
                color: Colors.white,
                size: 30,
              ),
            ),
            // child: CupertinoAlertDialog(
            //   title: Column(
            //     children: [
            //       SpinKitWave(
            //         color: Colors.grey,
            //         size: 50,
            //       ),
            //       // SizedBox(
            //       //   height: 30,
            //       // ),
            //       // Text('pleaseWait'.tr),
            //     ],
            //   ),
            // ),
          );
        },
      );
    } else {
      Get.back();
    }
  }
}

enum StatusSnackBar { success, error, waring, info, disabled }
