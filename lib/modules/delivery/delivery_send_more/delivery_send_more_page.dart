import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/theme/text_theme.dart';
import 'package:bccp_mobile_v2/widgets/app_listview_loarmore_with_checkox.dart';
import 'package:bccp_mobile_v2/widgets/custom_button.dart';
import 'package:bccp_mobile_v2/widgets/form/form_choose_picture.dart';
import 'package:bccp_mobile_v2/widgets/form/form_combobox_network.dart';
import 'package:bccp_mobile_v2/widgets/form/form_datetime_picker.dart';
import 'package:bccp_mobile_v2/widgets/form/form_input_text.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:bccp_mobile_v2/widgets/layout_loading.dart';
import 'package:bccp_mobile_v2/widgets/line_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'delivery_send_more_controller.dart';

class DeliverySendMorePage extends GetView<DeliverySendMoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(controller.titlePage.value ?? '')),
        ),
        body: Obx(
          () => LayoutLoading(
            isLoading: controller.isLoading.value,
            isSubmit: controller.isSubmit.value,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IfWidget(
                        condition: false,
                        right: Container(
                          width: MediaQuery.of(context).size.width,
                          color: BccpAppTheme.colorLightGreen,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '????n h??ng ???? ???????c giao\nv??o l??c 20/20/2021',
                                style: kWhiteText,
                              ),
                              Spacer(),
                              Icon(
                                LineIcons.truck,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              )
                            ],
                          ),
                          height: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'C?? ${controller.count.value} b??u g???i trong tuy???n ph??t'),
                      ),
                      AppListViewLoadMoreWithCheckBox(
                        onLoadMore: () {
                          controller.onLoadMorePackage();
                        },
                        onPress: (requestId, itemId, requestDetailId) {
                          // controller.doPackageNormal(requestId, itemId, requestDetailId);
                        },
                        onIgnore: (bool, itemId) {
                          if (!bool) {
                            controller.listPackageIgnore.add(itemId);
                          } else {
                            controller.listPackageIgnore.remove(itemId);
                          }
                        },
                        listValue: controller.listPackage.value,
                        listIgnore: controller.listPackageIgnore.value,
                        isEmpty: controller.emptyData.value,
                        isLoading: controller.isLoadingItemPaging.value,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            /// thong tin ng?????i g???i
                            BreakContent(
                              title: 'Th??ng tin b??u g???i',
                            ),
                            // LineInfo(
                            //   title: "G???i t???: ",
                            //   value: controller.senderCustomerName.value,
                            // ),
                            // LineInfo(
                            //   title: "?????a ch???: ",
                            //   value: controller.senderCustomerAddress.value,
                            // ),
                            LineInfo(
                              title: "N??i nh???n: ",
                              value: controller.deliveryPointName.value,
                            ),
                            LineInfo(
                              title: "?????a ch??? nh???n: ",
                              value: controller.receiverCustomerAddress.value,
                            ),

                            /// thong tin ng?????i nh???n
                            ///
                            ///
                            ///
                            BreakContent(
                              title: 'Th??ng tin ph??t',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  CupertinoSwitch(
                                    activeColor: mainColor,
                                    value: controller.isDeliverable.value,
                                    onChanged: (v) {
                                      controller.isDeliverable.value = v;
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Ph??t th??nh c??ng')
                                ],
                              ),
                            ),
                            FormDateTimePicker(
                              label: 'Ng??y gi??? ph??t',
                              value: controller.deliveryDate.value,
                              error: controller.deliveryDateError.value,
                              onChange: (value) {
                                controller.deliveryDateError.value = '';
                                controller.deliveryDate.value = value;
                              },
                              type: FormDateTimePickerType.dateTime,
                              // style: BccpAppTheme.textStyleBlue,
                            ),
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IfWidget(condition: controller.
                                isDeliverable.value && controller
                                    .isHaveDeliveryPoint.value, right: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text('Ng?????i th???c nh???n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),),
                                ),),
                                SizedBox(height: 5,),
                                IfWidget(
                                  condition: controller.isDeliverable.value,
                                  right: Container(
                                    child: Column(
                                      children: [
                                        IfWidget(
                                          condition: controller
                                              .isHaveDeliveryPoint.value,
                                          right: Row(
                                            children: [
                                              Expanded(
                                                child: FormComBoBoxNetwork(
                                                  // label: 'Ng?????i th???c nh???n',
                                                  prefix: IconButton(
                                                    icon: Icon(
                                                      Icons.call,
                                                      color: Colors.green,
                                                    ),
                                                    onPressed: () {
                                                      controller.onCall();
                                                    },
                                                    constraints: BoxConstraints(
                                                      maxHeight: 50,
                                                      maxWidth: 50,
                                                    ),
                                                  ),
                                                  suffix: IconButton(
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: mainColor,
                                                    ),
                                                    onPressed: () {
                                                      controller
                                                          .onAddDelivery();
                                                    },
                                                    constraints: BoxConstraints(
                                                      maxHeight: 50,
                                                      maxWidth: 50,
                                                    ),
                                                  ),
                                                  value: controller
                                                      .deliveryPointReceiver
                                                      .value,
                                                  error: controller
                                                      .deliveryPointReceiverError
                                                      .value,
                                                  onChange: (value) {
                                                    controller
                                                        .deliveryPointReceiver
                                                        .value = value !=
                                                        null
                                                        ? value['value']
                                                        : null;
                                                    controller
                                                        .findOneNguoiThucNhan(
                                                        value != null
                                                            ? value['value']
                                                            : null);
                                                    controller
                                                        .deliveryPointReceiverError
                                                        .value = '';
                                                  },
                                                  // style: BccpAppTheme.textStyleWhite,
                                                  hint: 'Ch??a ch???n',
                                                  apiUrl: BaseRepository
                                                      .getNguoiThucNhanCombobox,
                                                  params: {
                                                    'where': {
                                                      'customerCode': controller
                                                          .itemData[
                                                      'receiverCustomerCode'],
                                                      'deliveryPointCode':
                                                      controller.itemData[
                                                      'deliveryPointCode'],
                                                    }
                                                  },
                                                  // style: BccpAppTheme.textStyleBlue,
                                                ),
                                              ),

                                            ],
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                          ),
                                          wrong: FormInputText(
                                            onChange: (value) {
                                              controller.realReciverName
                                                  .value =
                                                  value;
                                              controller.realReciverNameError
                                                  .value = '';
                                            },
                                            value:
                                            controller.realReciverName.value,
                                            error: controller
                                                .realReciverNameError.value,
                                            label: 'Ng?????i th???c nh???n',
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            IfWidget(
                              condition: !controller.isDeliverable.value,
                              right: Container(
                                child: Column(
                                  children: [
                                    FormComBoBoxNetwork(
                                      label: 'L?? do kh??ng ph??t ???????c',
                                      value: controller.causeCode.value,
                                      error: controller.causeCodeError.value,
                                      onChange: (value) {
                                        controller.causeCode.value =
                                        value != null
                                            ? value['value']
                                            : null;
                                        controller.causeCodeError.value = '';
                                      },
                                      // style: BccpAppTheme.textStyleWhite,
                                      hint: 'Ch??a ch???n',
                                      apiUrl: BaseRepository
                                          .getLyDoKhongPhatDuocComBobox,
                                      params: {},
                                      // style: BccpAppTheme.textStyleBlue,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            FormInputText(
                              onChange: (value) {
                                controller.deliveryNote.value = value;
                                controller.deliveryNoteError.value =
                                '';
                              },
                              value: controller.deliveryNote.value,
                              error:
                              controller.deliveryNoteError.value,
                              maxLines: 3,
                              label: !controller.isDeliverable.value
                                  ? 'L?? do kh??c '
                                  : 'Ghi ch??',
                            ),
                            FormChoosePicture(
                              error: controller.attachFileError.value,
                              onSelectImage: (List list) {
                                controller.setImageList(list);
                                controller.attachFileError.value = '';
                              },
                              disabled: false,
                              listItem: controller.attachFile.value,
                              max: 3,
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        isLoading: controller.isSubmit.value,
                        text: controller.buttonText.value,
                        borderRadius: 30,
                        onPress: () {
                          controller.onPhat();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class BreakContent extends StatelessWidget {
  final String title;

  const BreakContent({Key key, this.title = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
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
