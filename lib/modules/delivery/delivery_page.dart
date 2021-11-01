import 'package:bccp_mobile_v2/core/utils/helpers.dart';
import 'package:bccp_mobile_v2/core/utils/show_webview.dart';
import 'package:bccp_mobile_v2/core/utils/util_color.dart';
import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:bccp_mobile_v2/modules/delivery/delivery_controller.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:bccp_mobile_v2/widgets/app_list_select_block.dart';
import 'package:bccp_mobile_v2/widgets/app_listview.dart';
import 'package:bccp_mobile_v2/widgets/container_widget.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:bccp_mobile_v2/widgets/search_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class DeliveryPage extends GetView<DeliveryController> {
  // final DeliveryController c = Get.put(DeliveryController());

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      appBar: AppBar(
        elevation: 0,
        title: Text('Danh sách tuyến phát'),
      ),
      child: Column(
        children: [
          SearchBoxWidget(
            onChange: (value) {
              controller.setTextDeliverySearch(value);
            },
            isMore: true,
          ),
          SizedBox(height: 5,),
          Obx(
            () => AppListSelectBlock(
              listValue: [
                {'value': null, 'text': 'Tất cả'},
                {'value': 2, 'text': 'Đã xác nhận đi phát'},
                {'value': 3, 'text': 'Đã nhập thông tin phát'},
                {'value': 4, 'text': 'Đã hoàn thành phát'},
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
                    allowLocation: true,
                    onChange: (value, type) {
                      if (type == AppListViewType.loadMore) {
                        controller.listDelivery.addAll(value);
                      } else {
                        controller.listDelivery.clear();
                        controller.listDelivery.addAll(value);
                      }
                    },
                    url: BaseRepository.getPagingDanhSachTuyenPhat,
                    reload: controller.reloadListView.value,
                    value: controller.listDelivery.value,
                    params: controller.params.value,
                    itemBuilder: (_, index, jsonData) {
                      return ItemPhatThuong(
                        index: index,
                        data: jsonData,
                      );
                    },
                  )))
        ],
      ),
    );
  }
}

class ItemPhatThuong extends StatelessWidget {
  final int index;
  final Map data;
  final DeliveryController c = Get.find();

  ItemPhatThuong({Key key, this.data, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.toNamed(Routes.DELIVERY_DETAIL, arguments: data);
      },
      child: Stack(children: [
        Container(
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
                    LineIcons.question,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  // height: 150,
                  // decoration: BoxDecoration(
                  //   borderRadius:
                  //       BorderRadius.horizontal(right: Radius.circular(20)),
                  //   color: Colors.grey.shade500,
                  // ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['deliveryRouteName'] ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Số lượng: ${data['quantity']}' ?? '',
                            style: TextStyle(fontSize: 10),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: data['status'] == 1
                                  ? Colors.grey
                                  : data['status'] == 2
                                  ? Colors.orangeAccent
                                  : Colors.green,
                            ),
                            child: Text(
                              Helpers.tuyenPhatStatus(data['status']),
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${Helpers.stringGTMToStringShort(data['date'])}',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                          // Text(
                          //   'Số lượng: ${data['totalNumber']??0}',
                          //   style: TextStyle(color: Colors.grey, fontSize: 10),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                // color: Colors.lightBlue,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  // color: Colors.lightBlue,
                ),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.WEB_VIEW_CUSTOM, arguments: {
                        'url': BaseRepository.baseUrl + '/ban-do-dp?id=${data['mailtripID']}&postCode=${c.authService.getCurrentUser().postCode}',
                        'title': data['deliveryRouteName']
                      });
                      // ShowWebView.show(url: 'https://google.com');
                    },
                    child: Image.asset(
                      'assets/images/icon_location.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        IfWidget(condition: data['messageText'] != null, right: Positioned(child: Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: UtilColor.getColorFromHex(data['messageColor']??'#FFDB290A'),
          ),
          child: Text(
            data['messageText']??'',
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ), bottom: 25, right: 55,))
      ],),
    );
  }
}
