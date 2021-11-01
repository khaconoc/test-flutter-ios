import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/theme/text_theme.dart';
import 'package:bccp_mobile_v2/widgets/custom_button.dart';
import 'package:bccp_mobile_v2/widgets/form/form_choose_picture.dart';
import 'package:bccp_mobile_v2/widgets/form/form_combobox_network.dart';
import 'package:bccp_mobile_v2/widgets/form/form_datetime_picker.dart';
import 'package:bccp_mobile_v2/widgets/form/form_input_text.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:bccp_mobile_v2/widgets/layout_loading.dart';
import 'package:bccp_mobile_v2/widgets/line_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'dart:convert';

import 'delivery_spec_send_one_controller.dart';

class DeliverySpecSendOnePage extends GetView<DeliverySpecSendOneController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Row(
          children: [
            Icon(
              LineIcons.barcode,
              size: 25,
            ),
            SizedBox(
              width: 5,
            ),
            Text(controller.itemCode.value ?? '')
          ],
        )),
        actions: [
          Obx(() => IfWidget(
              condition: controller.action.value == 'EDIT',
              right: IconButton(
                  icon: Icon(Icons.history_outlined),
                  onPressed: () {
                    Get.toNamed(Routes.DELIVERY_HISTORY, arguments: {
                      'itemID': controller.itemData['itemID'],
                      'itemCode': controller.itemData['itemCode'],
                      'deliveryIndex': controller.itemData['id']
                          ['deliveryIndex'],
                    });
                  })))
        ],
      ),
      body: Obx(
        () => LayoutLoading(
          isLoading: controller.isLoading.value,
          isSubmit: controller.isSubmit.value,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
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
                              'Đơn hàng đã được giao\nvào lúc 20/20/2021',
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
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: SizedBox(
                                child: SfBarcodeGenerator(
                                    value: controller.itemCode.value ?? ''),
                                width: MediaQuery.of(context).size.width - 50,
                                height: 50,
                              ),
                            ),
                            // Icon(
                            //   LineIcons.barcode,
                            //   size: 40,
                            // ),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            // Text(
                            //   controller.itemCode.value ?? '',
                            //   style: TextStyle(
                            //       fontSize: 30, fontWeight: FontWeight.bold),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          /// thong tin người gửi
                          BreakContent(
                            title: 'Thông tin bưu gửi',
                          ),
                          LineInfo(
                            title: "Gửi từ: ",
                            value: controller.senderCustomerName.value,
                          ),
                          LineInfo(
                            title: "Địa chỉ gửi: ",
                            value: controller.senderCustomerAddress.value,
                          ),
                          LineInfo(
                            title: "Nơi nhận: ",
                            value: controller.deliveryPointName.value,
                          ),
                          LineInfo(
                            title: "Địa chỉ nhận: ",
                            value: controller.receiverCustomerAddress.value,
                          ),

                          /// thong tin người nhận
                          ///
                          ///
                          ///
                          BreakContent(
                            title: 'Thông tin phát',
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
                                Text('Phát thành công'),
                                Spacer(),
                                IfWidget(
                                  condition: controller.retry.value != null,
                                  right: CupertinoSwitch(
                                    activeColor: mainColor,
                                    value: controller.retry.value ?? false,
                                    onChanged: (v) {
                                      controller.retry.value = v;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IfWidget(
                                  condition: controller.retry.value != null,
                                  right: Text(controller.retry.value ?? false
                                      ? 'Phát lại'
                                      : 'Cập nhật'),
                                )
                              ],
                            ),
                          ),
                          FormDateTimePicker(
                            label: 'Ngày giờ phát',
                            value: controller.deliveryDate.value,
                            error: controller.deliveryDateError.value,
                            onChange: (value) {
                              controller.deliveryDateError.value = '';
                              controller.deliveryDate.value = value;
                            },
                            type: FormDateTimePickerType.dateTime,
                            // style: BccpAppTheme.textStyleBlue,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IfWidget(
                                condition: controller.isDeliverable.value &&
                                    controller.isHaveDeliveryPoint.value,
                                right: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    'Người thực nhận',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
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
                                                // label: 'Người thực nhận',
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
                                                    controller.onAddDelivery();
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
                                                          .value =
                                                      value != null
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
                                                hint: 'Chưa chọn',
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
                                            controller.realReciverName.value =
                                                value;
                                            controller.realReciverNameError
                                                .value = '';
                                          },
                                          value:
                                              controller.realReciverName.value,
                                          error: controller
                                              .realReciverNameError.value,
                                          label: 'Người thực nhận',
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
                                    label: 'Lý do không phát được',
                                    value: controller.causeCode.value,
                                    error: controller.causeCodeError.value,
                                    onChange: (value) {
                                      controller.causeCode.value =
                                          value != null ? value['value'] : null;
                                      controller.causeCodeError.value = '';
                                    },
                                    // style: BccpAppTheme.textStyleWhite,
                                    hint: 'Chưa chọn',
                                    apiUrl: BaseRepository
                                        .getLyDoKhongPhatDuocComBobox,
                                    params: {},
                                    // style: BccpAppTheme.textStyleBlue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          FormInputText(
                            onChange: (value) {
                              controller.deliveryNote.value = value;
                              controller.deliveryNoteError.value = '';
                            },
                            value: controller.deliveryNote.value,
                            error: controller.deliveryNoteError.value,
                            maxLines: 3,
                            label: !controller.isDeliverable.value
                                ? 'Lý do khác '
                                : 'Ghi chú',
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
                      text: (controller.retry.value??false) ? 'Phát lại bưu gửi' : controller.buttonText.value,
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
