import 'package:bccp_mobile_v2/core/utils/helpers.dart';
import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:bccp_mobile_v2/modules/search/search_controller.dart';
import 'package:bccp_mobile_v2/modules/search/widgets/search_list_widget.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/app_combobox_network.dart';
import 'package:bccp_mobile_v2/widgets/app_listview.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:bccp_mobile_v2/widgets/list_frist_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class SearchPage extends GetView<SearchController> {


  @override
  Widget build(BuildContext context) {
    // Get.put(SearchController());
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Tìm kiếm gói hàng'),
      // ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
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
                                  child: TextField(
                                    onChanged: (value) {
                                      controller.setValueSearchText(value);
                                    },
                                    controller: controller.textEditingController,
                                    // enabled: c,
                                    focusNode: controller.myFocusNode,
                                    // autofocus: true,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                        border: InputBorder.none, hintText: 'searchPostage'.tr),
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: IconButton(
                                    icon: Image.asset('assets/images/icon_scan.png'),
                                    onPressed: () async {
                                      await Permission.camera.request();
                                      String photoScanResult = await scanner.scan();
                                      if(photoScanResult.isNotEmpty) {
                                        controller.textEditingController.text = photoScanResult;
                                        // Get.toNamed(Routes.POSTAGE, arguments: photoScanResult);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Obx(() => AppListView(
                  key: controller.listViewPagingKey,
                  onChange: (value, type) {
                    if (type == AppListViewType.loadMore) {
                      controller.listOfDataSearch.addAll(value);
                    } else {
                      controller.listOfDataSearch.clear();
                      controller.listOfDataSearch.addAll(value);
                    }
                  },
                  url: BaseRepository.getSearchPaging,
                  value: controller.listOfDataSearch.value,
                  params: controller.params.value,
                  itemBuilder: (_, index, jsonData) {
                    return ItemSearch(
                      data: jsonData,
                    );
                  },
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemSearch extends StatelessWidget {
  final Map data;

  ItemSearch({Key key, @required this.data}) : super(key: key);


  Widget _renderItem(int index, Map data) {
    String imageUrl = Helpers.getFirstImageString(data['attachFile']);
    String groupTitle = '';
    Color color = Helpers.trangThaiPhatBuuGuiColor(data['itemStatus']);
    // ReceiverAddress
    // DeliveryPointName
    return Container(
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
                      if (data['dataType'].toString().toUpperCase() == 'PHATDACBIET') {
                        Get.toNamed(Routes.DELIVERY_SPEC_SEND_ONE, arguments: data);
                      } else {
                        Get.toNamed(Routes.DELIVERY_SEND_ONE, arguments: data);
                      }
                      // widget.onPress(
                      //     data['requestID'], data['itemID'], data['requestDetailID']);
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
                                        height: 100,
                                        width: 100,
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
                                        height: 100,
                                        width: 100,
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
                                            Text('${data['senderAddress']}' , style: TextStyle(fontSize: 10),),
                                            // Text('Nhận: ${data['receiverName']}'),
                                            Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: color,
                                              ),
                                              child: Text(
                                                Helpers.trangThaiPhatBuuGui(data['itemStatus']),
                                                style: TextStyle(fontSize: 10, color: Colors.white),
                                              ),
                                            ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 10, left: 10, bottom: 8),
          //   child: Text(data['deliveryRouteName']??''),
          // ),
          _renderItem(0, data)
          // renderListItem(data['items'] as List)
        ],
      ),
    );
  }
}