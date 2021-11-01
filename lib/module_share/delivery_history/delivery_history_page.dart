import 'package:bccp_mobile_v2/core/utils/helpers.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:bccp_mobile_v2/widgets/list_short_frist_loading_widget.dart';
import 'package:bccp_mobile_v2/widgets/tag_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'delivery_history_controller.dart';

class DeliveryHistoryPage extends GetView<DeliveryHistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title.value ?? '')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Obx(() => Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    BreakContent(
                      title: 'Lịch sử bưu gửi',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    IfWidget(
                        condition: controller.isLoadingHisItem.value,
                        right: ListShortFirstLoadingWidget(
                          count: 2,
                        ),
                        wrong: IfWidget(
                          condition: controller.listOfDataHisItem.length == 0,
                          right: Center(
                            child: Text('Không có dữ liệu'),
                          ),
                        )),
                    ...List.generate(
                        controller.listOfDataHisItem.length,
                        (index) => ItemHistoryPackage(
                              index: index,
                              data: controller.listOfDataHisItem[index],
                            )),
                    SizedBox(
                      height: 10,
                    ),
                    BreakContent(
                      title: 'Lịch sử cuộc gọi',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    IfWidget(
                        condition: controller.isLoadingHisCall.value,
                        right: ListShortFirstLoadingWidget(
                          count: 2,
                        ),
                        wrong: IfWidget(
                          condition: controller.listOfDataHisCall.length == 0,
                          right: Center(
                            child: Text('Không có dữ liệu'),
                          ),
                        )),
                    ...List.generate(
                        controller.listOfDataHisCall.length,
                        (index) => ItemHistoryCall(
                              index: index,
                              data: controller.listOfDataHisCall[index],
                            )),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class ItemHistoryPackage extends StatelessWidget {
  final int index;
  final Map data;

  ItemHistoryPackage({Key key, this.data, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      // height: 80,
      decoration: BoxDecoration(

          // borderRadius: BorderRadius.all(
          //   Radius.circular(20)
          // )
          ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            // color: Colors.lightBlue,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.lightBlue,
            ),
            child: Center(
              child: Icon(
                LineIcons.history,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ghi chú: ${data['deliveryNote'] ?? ''}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      TagWidget(
                        color: !data['isDeliverable']
                            ? Colors.redAccent
                            : Colors.lightGreen,
                        text:
                            !data['isDeliverable'] ? 'Thất bại' : 'Thành công',
                      ),
                      Spacer(),
                      Text(
                        Helpers.stringGTMToStringFull(data['datetime']) ?? '',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  IfWidget(
                      condition: data['causeCode'] != null,
                      right: Text('${data['causeCode']}'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemHistoryCall extends StatelessWidget {
  final int index;
  final Map data;

  ItemHistoryCall({Key key, this.data, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      // height: 80,
      decoration: BoxDecoration(

          // borderRadius: BorderRadius.all(
          //   Radius.circular(20)
          // )
          ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            // color: Colors.lightBlue,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.lightBlue,
            ),
            child: Center(
              child: Icon(
                LineIcons.phone,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nguyễn Văn Đức',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        data['phone'] ?? '',
                        style: TextStyle(fontSize: 10),
                      ),
                      Spacer(),
                      Text(
                        Helpers.stringGTMToStringFull(data['datetime']) ?? '',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BreakContent extends StatelessWidget {
  final String title;

  const BreakContent({Key key, this.title = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: mainColor, width: 0.5),
                          ),
                        ),
                      ),
                      Container(height: 9,)
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}
