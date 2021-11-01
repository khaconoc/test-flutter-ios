import 'package:bccp_mobile_v2/core/utils/helpers.dart';
import 'package:bccp_mobile_v2/core/utils/show_webview.dart';
import 'package:bccp_mobile_v2/core/utils/util_color.dart';
import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:bccp_mobile_v2/modules/delivery/delivery_detail/delivery_detail_controller.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/app_list_select_block.dart';
import 'package:bccp_mobile_v2/widgets/app_listview.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:bccp_mobile_v2/widgets/search_box_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryDetailPage extends GetView<DeliveryDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.dataRoute['deliveryRouteName'] ?? ''),
        actions: [
          IconButton(
            icon: Icon(
              Icons.done_all,
              color: Colors.white,
            ),
            onPressed: () {
              controller.onHoanThanh();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBoxWidget(
              onChange: (value) {
                controller.setSearch(value);
              },
              isMore: true,
            ),
            SizedBox(
              height: 5,
            ),
            Obx(
              () => AppListSelectBlock(
                listValue: [
                  {'value': null, 'text': 'Tất cả'},
                  {'value': 0, 'text': 'Chưa phát'},
                  {'value': 1, 'text': 'Phát thành công'},
                  {'value': 2, 'text': 'Phát thất bại'},
                ],
                value: controller.status.value,
                onChange: (value) {
                  controller.onChangeStatus(value);
                },
              ),
            ),
            Expanded(
              child: Obx(
                () => AppListView(
                  key: controller.listViewPagingKey,
                  showSeparator: false,
                  allowLocation: true,
                  onChange: (value, type) {
                    controller.groupTitle.value = '';
                    if (type == AppListViewType.loadMore) {
                      controller.listDelivery
                          .addAll(this.controller.renderTitle(value));
                    } else {
                      controller.listDelivery.clear();
                      controller.groupTitleSet.clear();
                      controller.listDelivery
                          .addAll(this.controller.renderTitle(value));
                    }
                  },
                  url: BaseRepository.getPagingBuuGuiTrongTuyenPhat,
                  value: controller.listDelivery.value,
                  params: controller.params.value,
                  itemBuilder: (_, index, jsonData) {
                    return MailTripItem(
                      data: jsonData,
                    );
                  },
                ),
              ),
            ),
            // CustomButton(
            //   onPress: () {
            //     controller.onPhatNhieu();
            //   },
            //   borderRadius: 30,
            //   text: 'Phát nhiều',
            // )
          ],
        ),
      ),
    );
  }
}

class MailTripItem extends StatelessWidget {
  final Map data;
  final DeliveryDetailController c = Get.find();

  MailTripItem({Key key, @required this.data}) : super(key: key);

  // Widget renderListItem(List listItem) {
  //   return Container(
  //     child: Column(
  //       children: [
  //         ...List.generate(
  //             listItem.length, (index) => Text(listItem[index]['receiverName']))
  //       ],
  //     ),
  //   );
  // }

  Widget _renderItem(int index, Map data) {
    String imageUrl = Helpers.getFirstImageString(data['attachFile']);
    // String groupTitle = '';
    Color color = Helpers.trangThaiPhatBuuGuiColor(data['itemStatus']);
    // // ReceiverAddress
    // // DeliveryPointName
    // String temp = '${data['deliveryPointName']} ${data['receiverAddress']} ${data['deliveryPointName']}';
    // if(temp != c.groupTitle.value) {
    //   groupTitle = data['deliveryPointName'];
    //   c.groupTitle.value = temp;
    // }
    return Stack(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    color: mainColor.withAlpha(30),
                    border: Border(
                        left: BorderSide(
                      color: color,
                      width: 5,
                    ))),
                child: Row(
                  children: [
                    // Checkbox(value: false, onChanged: (value) {}),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          // widget.onPress(
                          //     data['requestID'], data['itemID'], data['requestDetailID']);
                          Get.toNamed(Routes.DELIVERY_SEND_ONE, arguments: data);
                          // Get.toNamed(Routes.POSTAGE);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        imageUrl.isNotEmpty
                                            ? ClipRRect(
                                                child: FadeInImage.assetNetwork(
                                                  image: imageUrl,
                                                  height: 70,
                                                  width: 70,
                                                  placeholder:
                                                      'assets/images/image_loading.gif',
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )
                                            : ClipRRect(
                                                child: Image.asset(
                                                  'assets/images/no-image.png',
                                                  height: 70,
                                                  width: 70,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(data['itemCode'] ?? ''),
                                                Text('Từ: ${data['senderName']}'),
                                                Text(
                                                  '${data['senderAddress']}',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                                // Text('Nhận: ${data['receiverName']}'),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(2),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        color: color,
                                                      ),
                                                      child: Text(
                                                        Helpers.trangThaiPhatBuuGui(
                                                            data['itemStatus']),
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      Helpers.stringGTMToStringFull(
                                                              data[
                                                                  'deliveryTime']) ??
                                                          '',
                                                      style:
                                                          TextStyle(fontSize: 10),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // height: 100,
                              ),
                              // Positioned(
                              //     left: 0,
                              //     top: 0,
                              //     child: Container(
                              //       width: 20,
                              //       height: 20,
                              //       decoration: BoxDecoration(
                              //           color: Colors.redAccent,
                              //           borderRadius: BorderRadius.circular(50)),
                              //       child: Center(
                              //           child: Text(
                              //             '${index + 1}',
                              //             style: BccpAppTheme.textStyleWhite,
                              //           )),
                              //     )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
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
        ), top: 17, right: 10,))
      ],
    );
  }

  Widget _renderGroup(int index, Map data) {
    var groupTitle = data['deliveryPointName'];
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(temp),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                c.onOpenMap(data);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Expanded(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/icon_location.png',
                          width: 30,
                          height: 30,
                        ),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(groupTitle ?? ''),
                            Text(
                              data['receiverAddress'] ?? '',
                              style:
                              TextStyle(fontSize: 10, color: Colors.blueAccent),
                            ),
                          ],
                        ),)
                      ],
                    ),
                  ),
                  // Spacer(),
                  IfWidget(condition: c.status.value == null || c.status.value == 0, right: RichText(
                    text: TextSpan(
                      text: 'Phát nhiều',
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          // controller.openMap();
                          Get.toNamed(Routes.DELIVERY_SEND_MORE,
                              arguments: data);
                        },
                    ),
                  ),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IfWidget(
            condition: data['type'] == 'title',
            right: _renderGroup(0, data),
            wrong: _renderItem(0, data),
          )
        ],
      ),
    );
  }
}
