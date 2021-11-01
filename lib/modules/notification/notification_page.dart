import 'package:bccp_mobile_v2/data/model/notification/notification_model.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'notification_controller.dart';

class NotificationPage extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo'),
        actions: [
          IconButton(
            icon: Icon(Icons.playlist_add_check_outlined),
            onPressed: () {
              controller.onMaskSeenAll();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ItemNotification(notification: new NotificationModel(
                        id: 1,
                        message: 'mess',
                        title: 'Thông báo ứng dụng',
                        seen: false,
                        time: '2020'
                    ),),
                    ItemNotification(notification: new NotificationModel(
                        id: 1,
                        message: 'mess',
                        title: 'Thông báo ứng dụng',
                        seen: true,
                        time: '2020'
                    ),),
                    ItemNotification(notification: new NotificationModel(
                        id: 1,
                        message: 'mess',
                        title: 'Thông báo ứng dụng',
                        seen: true,
                        time: '2020'
                    ),),
                  ],
                ),
              ),
              Text('Bạn có 3 thông báo chưa đọc', style: TextStyle(color: Colors.grey),)
            ],
          ),
        ),
      ),
    );
  }
}

class ItemNotification extends StatelessWidget {
  final NotificationModel notification;

  ItemNotification({@required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.NOTIFICATION_DETAIL, arguments: notification);
      },
      child: Container(
        // color: mainColor.withAlpha(100),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70), color: !notification.seen ? mainColor : Colors.grey.withAlpha(400)),
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông báo ứng dụng',
                  style: TextStyle(
                    fontWeight: !notification.seen ? FontWeight.bold : null,
                  ),
                ),
                Text(
                  '19:40 11/05/2021',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontWeight: !notification.seen ? FontWeight.bold : null,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
