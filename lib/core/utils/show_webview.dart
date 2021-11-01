import 'dart:io';

import 'package:bccp_mobile_v2/widgets/layout/layout_bottom_sheet.dart';
import 'package:bccp_mobile_v2/widgets/layout_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowWebView {
  static void show({String url}) {
    showModalBottomSheet<void>(
      context: Get.context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (thisLowerContext, innerSetState) {
          ///**************************************************************
          /// tách ra widget mới vì để chung khó setState để rerender UI được
          return LayoutBottomSheet(
            title: 'widget.hint',
            textActionRight: 'Đóng',
            height: MediaQuery.of(context).size.height - 50,
            onPressActionRight: () {

            },
            child: Expanded(
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: ContentWebView()
              ),
            ),
          );
        });
      },
    );
  }
}

class ContentWebView extends StatefulWidget {
  @override
  _ContentWebViewState createState() => _ContentWebViewState();
}

class _ContentWebViewState extends State<ContentWebView> {
  // @override
  // void initState() {
  //   super.initState();
  //   // Enable hybrid composition.
  //   if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  // }

  var isLoading = true;
  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return LayoutLoading(
      isLoading: false,
      isSubmit: isLoading,
      child: WebView(
        initialUrl: 'https://google.com',
          javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (finish) {
          print('finish' + finish);
          setLoading(false);
        },
        // onProgress: (int progress) {
        //   print("WebView is loading (progress : $progress%)");
        // },
      ),
    );
  }
}
