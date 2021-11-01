import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_detail_controller.dart';

class NotificationDetailPage extends GetView<NotificationDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Center(
                child: Text(
                  'Tieu de ne',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'Thanh Profile PE là kết quả của việc kết hợp giữa 70% bột gỗ và 30% hạt nhựa PE nguyên sinh, chất trợ liên kết và một số chất phụ gia nhằm tăng cường đặc tính của gỗ nhựa Composite. Vì vậy WPC được gọi là vật liệu sợi tự nhiên được gia cường bằng composite nhựa',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
