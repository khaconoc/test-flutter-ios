import 'package:bccp_mobile_v2/core/utils/helpers.dart';
import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:bccp_mobile_v2/widgets/app_combobox_local.dart';
import 'package:bccp_mobile_v2/widgets/app_combobox_network.dart';
import 'package:bccp_mobile_v2/widgets/app_list_select_block.dart';
import 'package:bccp_mobile_v2/widgets/app_listview.dart';
import 'package:bccp_mobile_v2/widgets/search_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'receive_controller.dart';

class ReceivePage extends GetView<ReceiveController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.white,
        title: Text('Danh sách yêu cầu'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              // color: Colors.grey.withAlpha(100),
            ),
            onPressed: () {
              controller.onDetail({'id': null, 'index': -1});
              // Navigator.push(context, MaterialPageRoute(builder: (_) => PostageHisView()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchBoxWidget(
              onChange: (value) {
                controller.setTextSearch(value);
              },
              // onMore: () {
              //   DialogService.showBottomSheet(children: [
              //     ListTile(
              //       leading: Icon(LineIcons.steam),
              //       title: Text('bo loc 1'),
              //     ),
              //     ListTile(
              //       leading: Icon(LineIcons.steam),
              //       title: Text('bo loc 1'),
              //     ),
              //     ListTile(
              //       leading: Icon(LineIcons.steam),
              //       title: Text('bo loc 1'),
              //     ),
              //   ]);
              // },
            ),
            Obx(
              () => Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text('Lọc: '),
                      AppComboBoxNetwork(
                        value: controller.customer.value,
                        onChange: (value) {
                          controller.onChangeCustomer(
                              value != null ? value['value'] : '');
                          // print(value);
                        },
                        // style: BccpAppTheme.textStyleWhite,
                        hint: 'Chọn khách hàng',
                        apiUrl: BaseRepository.getCustomerCombobox,
                        params: {},
                      )
                    ],
                  )),
            ),
            // Obx(
            //   () => Container(
            //       child: Row(
            //     children: [
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text('Lọc theo trạng thái: '),
            //       AppComboBoxLocal(
            //         value: controller.status.value,
            //         onChange: (value) {
            //           controller.onChangeStatus(
            //               value != null ? value['value'] : null);
            //         },
            //         // style: BccpAppTheme.textStyleWhite,
            //         hint: 'Trạng trái',
            //         listValue: [
            //           // {'value': 1, 'text': 'Đang khởi tạo'},
            //           {'value': 2, 'text': 'Chờ bưu tá xác nhận'},
            //           {'value': 3, 'text': 'Bưu tá đã xác nhận'},
            //           {'value': 4, 'text': 'Chờ GDV xác nhận'},
            //           {'value': 5, 'text': 'GDV đã xác nhận'},
            //           {'value': 6, 'text': 'GDV từ chối nhận'},
            //           {'value': 7, 'text': 'Đã chấp nhận'},
            //         ],
            //       )
            //     ],
            //   )),
            // ),
            Obx(
              () => AppListSelectBlock(
                listValue: [
                  {'value': null, 'text': 'Tất cả'},
                  {'value': 2, 'text': 'Chờ bưu tá xác nhận'},
                  {'value': 3, 'text': 'Bưu tá đã xác nhận'},
                  // {'value': 4, 'text': 'Bưu tá từ chối nhận'},
                  {'value': 5, 'text': 'Chờ GDV xác nhận'},
                  {'value': 6, 'text': 'GDV đã xác nhận'},
                  {'value': 7, 'text': 'GDV từ chối nhận'},
                  {'value': 8, 'text': 'Đã chấp nhận'},
                ],
                value: controller.status.value,
                onChange: (value) {
                  controller.onChangeStatus(value);
                },
              ),
            ),
            Expanded(
              child: Obx(() => AppListView(
                    key: controller.listViewPagingKey,
                    onChange: (value, type) {
                      if (type == AppListViewType.loadMore) {
                        controller.listRequestAccepted.addAll(value);
                      } else {
                        controller.listRequestAccepted.clear();
                        controller.listRequestAccepted.addAll(value);
                      }
                    },
                    url: BaseRepository.getRequestAcceptedPaging,
                    value: controller.listRequestAccepted.value,
                    params: controller.params.value,
                    itemBuilder: (_, index, jsonData) {
                      return ItemListReceiveAccepted(
                        index: index,
                        data: jsonData,
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemListReceiveAccepted extends StatelessWidget {
  final int index;
  final Map data;

  ItemListReceiveAccepted({Key key, this.data, this.index}) : super(key: key);

  final ReceiveController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        c.onDetail({'id': data['requestID'], 'index': index});
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        height: 80,
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
                  LineIcons.user,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                  child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data['senderFullName'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data['senderAddress'],
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          Helpers.requestStatusToStringNormal(data['status']),
                          style: TextStyle(fontSize: 10, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${Helpers.stringGTMToStringShort(data['date'])}',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      Text(
                        'Số lượng: ${data['totalNumber']??0}',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  )
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
