import 'package:bccp_mobile_v2/widgets/layout_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'web_view_custom_controller.dart';

class WebViewCustomPage extends GetView<WebViewCustomController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() => LayoutLoading(
        isLoading: false,
        isSubmit: controller.isLoading.value,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  // height: 20,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(controller.title??''),
                  ),
                ),
              ],
            ),
            Expanded(child: WebView(
              initialUrl: controller.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                print('finish' + finish);
                controller.isLoading.value = false;
              },
              // onProgress: (int progress) {
              //   print("WebView is loading (progress : $progress%)");
              // },
            ))
          ],
        ),
      ))),
    );
  }
}