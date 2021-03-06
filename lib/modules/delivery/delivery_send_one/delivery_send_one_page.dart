import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/theme/text_theme.dart';
import 'package:bccp_mobile_v2/widgets/custom_button.dart';
import 'package:bccp_mobile_v2/widgets/form/form_choose_picture.dart';
import 'package:bccp_mobile_v2/widgets/form/form_combobox_local.dart';
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

import 'delivery_send_one_controller.dart';

class DeliverySendOnePage extends GetView<DeliverySendOneController> {
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
        body: Obx(() => LayoutLoading(
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
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                //       fontSize: 30,
                                //       fontWeight: FontWeight.bold),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              /// thong tin ng?????i g???i
                              BreakContent(
                                title: 'Th??ng tin b??u g???i',
                              ),
                              LineInfo(
                                title: "G???i t???: ",
                                value: controller.senderCustomerName.value,
                              ),
                              LineInfo(
                                title: "?????a ch??? G???i: ",
                                value: controller.senderCustomerAddress.value,
                              ),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
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
                                    Text('Ph??t th??nh c??ng'),
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
                                      right: Text(
                                          controller.retry.value ?? false
                                              ? 'Ph??t l???i'
                                              : 'C???p nh???t'),
                                    )
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
                                        'Ng?????i th???c nh???n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                                    // label: 'Ng?????i th???c nh???n',
                                                    prefix: IconButton(
                                                      icon: Icon(
                                                        Icons.call,
                                                        color: Colors.green,
                                                      ),
                                                      onPressed: () {
                                                        controller.onCall();
                                                      },
                                                      constraints:
                                                          BoxConstraints(
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
                                                      constraints:
                                                          BoxConstraints(
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
                                                                  ? value[
                                                                      'value']
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
                                                    .value = value;
                                                controller.realReciverNameError
                                                    .value = '';
                                              },
                                              value: controller
                                                  .realReciverName.value,
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
                                    ? 'L?? do kh??c '
                                    : 'Ghi ch??',
                              ),
                              IfWidget(
                                  condition: controller.isAr.value,
                                  right: ThongTinChungTuChuyenTraWidget()),
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
                          text: (controller.retry.value ?? false)
                              ? 'Ph??t l???i b??u g???i'
                              : controller.buttonText.value,
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
            )));
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

class ThongTinChungTuChuyenTraWidget extends StatelessWidget {
  final DeliverySendOneController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            BreakContent(
              title: 'Th??ng tin ch???ng t??? chuy???n tr???',
            ),
            SizedBox(
              height: 10,
            ),
            FormDateTimePicker(
              label: 'Ng??y l???p',
              value: controller.createDateR.value,
              error: controller.createDateRError.value,
              onChange: (value) {
                controller.createDateR.value = value;
                controller.createDateRError.value = '';
              },
              type: FormDateTimePickerType.dateTime,
            ),
            SizedBox(
              height: 10,
            ),
            FormComBoBoxLocal(
              onChange: (value) {
                controller.typeR.value = value != null ? value['value'] : null;
                controller.typeRError.value = '';
              },
              value: controller.typeR.value,
              listItem: [
                {'value': '1', 'text': 'B??u c???c g???c'},
                {'value': '2', 'text': 'B??u c???c kh??c'},
                {'value': '3', 'text': '?????a ch???'},
              ],
              label: 'Lo???i',
              hint: 'Ch???n',
              allowClear: false,
            ),
            SizedBox(
              height: 10,
            ),
            IfWidget(
              condition: controller.typeR.value == '1',
              right: FormComBoBoxNetwork(
                disabled: true,
                label: 'B??u c???c g???c',
                value: controller.posCodeOringinR.value,
                error: controller.pOSCodeOringinRError.value,
                onChange: (value) {
                  controller.posCodeOringinR.value =
                      value != null ? value['value'] : null;
                  controller.pOSCodeOringinRError.value = '';
                },
                // style: BccpAppTheme.textStyleWhite,
                hint: 'Ch???n b??u c???c g???c',
                apiUrl: BaseRepository.getPosCombobox,
                params: {},
                // style: BccpAppTheme.textStyleBlue,
              ),
            ),
            IfWidget(
              condition: controller.typeR.value == '2',
              right: FormComBoBoxNetwork(
                label: 'B??u c???c kh??c',
                value: controller.posCodeNewR.value,
                error: controller.pOSCodeNewRError.value,
                onChange: (value) {
                  controller.posCodeNewR.value =
                      value != null ? value['value'] : null;
                  controller.pOSCodeNewRError.value = '';
                },
                // style: BccpAppTheme.textStyleWhite,
                hint: 'Ch???n b??u c???c kh??c',
                apiUrl: BaseRepository.getPosCombobox,
                params: {},
                // style: BccpAppTheme.textStyleBlue,
              ),
            ),
            IfWidget(
              condition: controller.typeR.value != '3',
              right: SizedBox(
                height: 10,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: FormInputText(
                  onChange: (value) {
                    controller.itemCodeR.value = value;
                    controller.itemCodeRError.value = '';
                  },
                  value: controller.itemCodeR.value,
                  error: controller.itemCodeRError.value,
                  label: 'S??? hi???u gi???y b??o ph??t',
                ),),
                IconButton(onPressed: () {
                  controller.scanCode();
                }, icon: Icon(Icons.qr_code_scanner_outlined))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            FormInputText(
              onChange: (value) {
                controller.receiverNameR.value = value;
                controller.receiverNameRError.value = '';
              },
              value: controller.receiverNameR.value,
              error: controller.receiverNameRError.value,
              label: 'H??? t??n ng?????i nh???n',
            ),
            SizedBox(
              height: 10,
            ),
            FormInputText(
              onChange: (value) {
                controller.receiverAddressR.value = value;
                controller.receiverAddressRError.value = '';
              },
              value: controller.receiverAddressR.value,
              error: controller.receiverAddressRError.value,
              label: '?????a ch??? ng?????i nh???n',
            ),
            SizedBox(
              height: 10,
            ),
            FormComBoBoxNetwork(
              label: 'T???nh/TP',
              value: controller.provinceR.value,
              error: controller.provinceRError.value,
              onChange: (value) {
                controller
                    .onSelectProvince(value != null ? value['value'] : null);
                controller.provinceRError.value = '';
              },
              // style: BccpAppTheme.textStyleWhite,
              hint: 'Ch???n T???nh/TP',
              apiUrl: BaseRepository.getProvinceCombobox,
              params: {},
              // style: BccpAppTheme.textStyleBlue,
            ),
            SizedBox(
              height: 10,
            ),
            FormComBoBoxNetwork(
              label: 'Qu???n/Huy???n',
              value: controller.districtR.value,
              error: controller.districtRError.value,
              disabled: controller.provinceR.value == null ||
                  controller.provinceR.value.isEmpty,
              onChange: (value) {
                controller
                    .onSelectDistrict(value != null ? value['value'] : null);
                controller.districtRError.value = '';
              },
              // style: BccpAppTheme.textStyleWhite,
              hint: 'Ch???n Qu???n/Huy???n',
              apiUrl: BaseRepository.getDistrictCombox,
              params: {'provinceCode': controller.provinceR.value},
              // style: BccpAppTheme.textStyleBlue,
            ),
            SizedBox(
              height: 10,
            ),
            FormComBoBoxNetwork(
              disabled: controller.districtR.value == null ||
                  controller.districtR.value.isEmpty,
              label: 'Ph?????ng x??',
              value: controller.communeR.value,
              error: controller.communeRError.value,
              onChange: (value) {
                controller.communeR.value =
                    value != null ? value['value'] : null;
                controller.communeRError.value = '';
              },
              // style: BccpAppTheme.textStyleWhite,
              hint: 'Ch???n Ph?????ng x??',
              apiUrl: BaseRepository.getCommuneCombobox,
              params: {'districtCode': controller.districtR.value},
              // style: BccpAppTheme.textStyleBlue,
            ),
          ],
        ));
  }
}
