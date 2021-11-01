import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:bccp_mobile_v2/widgets/custom_button.dart';
import 'package:bccp_mobile_v2/widgets/form/form_choose_picture.dart';
import 'package:bccp_mobile_v2/widgets/form/form_combobox_network.dart';
import 'package:bccp_mobile_v2/widgets/form/form_datetime_picker.dart';
import 'package:bccp_mobile_v2/widgets/form/form_input_number.dart';
import 'package:bccp_mobile_v2/widgets/form/form_input_text.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'receive_package_crud_controller.dart';

class ReceivePackageCrudPage extends GetView<ReceivePackageCrudController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi Tiết bưu gửi'),
      ),
      body: SafeArea(
        child: Obx(() => SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        IfWidget(
                          condition: controller.itemCode.value != null &&
                              controller.itemCode.value != '',
                          right: FormInputText(
                            disabled: true,
                            onChange: (value) {
                              controller.itemCode.value = value;
                              controller.itemCodeError.value = '';
                            },
                            value: controller.itemCode.value,
                            error: controller.itemCodeError.value,
                            label: 'Số hiệu bưu gửi',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormInputText(
                          onChange: (value) {
                            controller.itemCodeCustomer.value = value;
                            controller.itemCodeCustomerError.value = '';
                          },
                          value: controller.itemCodeCustomer.value,
                          error: controller.itemCodeCustomerError.value,
                          label: 'Số công văn',
                          important: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: FormComBoBoxNetwork(
                                // error: controller.itemTypeError.value,
                                label: 'Loại bưu gửi',
                                important: true,
                                value: controller.itemTypeCode.value,
                                error: controller.itemTypeCodeError.value,
                                onChange: (value) {
                                  // controller.itemTypeError.value = '';
                                  controller.itemTypeCode.value =
                                      value == null ? null : value['value'];
                                  controller.itemTypeCodeError.value = '';
                                  // controller.itemTypeName.value =
                                  // value != null ? value['text'] : '';
                                },
                                // style: BccpAppTheme.textStyleWhite,
                                hint: 'Chọn loại bưu gửi',
                                apiUrl: BaseRepository.getItemTypeCombobox,
                                params: {},
                              ),
                              flex: 3,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: IfWidget(
                                condition: controller.listHenGio[
                                        controller.itemTypeCode.value] !=
                                    null,
                                right: FormDateTimePicker(
                                  label: 'Giờ hẹn',
                                  value: controller.timerDelivery.value,
                                  error: controller.timerDeliveryError.value,
                                  onChange: (value) {
                                    controller.timerDelivery.value = value;
                                    controller.timerDeliveryError.value = '';
                                  },
                                  type: FormDateTimePickerType.time,
                                  // style: BccpAppTheme.textStyleBlue,
                                ),
                              ),
                              flex: 2,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormInputNumber(
                          onChange: (value) {
                            controller.weight.value = value;
                            controller.weightError.value = '';
                          },
                          value: controller.weight.value,
                          error: controller.weightError.value,
                          label: 'Khối lượng (gr)',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormInputText(
                          label: 'Cơ quan nhận khác / Khách hàng cá nhân',
                          onChange: (value) {
                            controller.receiverFullName.value = value;
                            controller.receiverFullNameError.value = '';
                          },
                          value: controller.receiverFullName.value,
                          error: controller.receiverFullNameError.value,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormComBoBoxNetwork(
                          label: 'Cơ quan nhận',
                          value: controller.receiverCustomerCode.value,
                          error: controller.receiverCustomerCodeError.value,
                          onChange: (value) {
                            controller.receiverCustomerCode.value =
                            value != null ? value['value'] : null;
                            controller.onSelectCoQuanNhan(
                                value != null ? value['value'] : "");
                            controller.receiverCustomerCodeError.value = '';
                          },
                          // style: BccpAppTheme.textStyleWhite,
                          hint: 'Chọn cơ quan nhận',
                          apiUrl:
                          BaseRepository.getCustomerCombobox,
                          params: {},
                          // style: BccpAppTheme.textStyleBlue,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormComBoBoxNetwork(
                          label: 'Điểm phát',
                          value: controller.deliveryPointCode.value,
                          error: controller.deliveryPointCodeError.value,
                          onChange: (value) {
                            controller.deliveryPointCode.value =
                                value != null ? value['value'] : null;
                            // controller.onChangeDiemPhat(value != null ? value['value'] : null);
                            // print(value);
                            controller.onSelectDiemPhat(
                                value != null ? value['value'] : "");
                            controller.deliveryPointCodeError.value = '';
                          },
                          // style: BccpAppTheme.textStyleWhite,
                          hint: 'Chọn điểm phát',
                          apiUrl:
                              BaseRepository.getDeliveryPointCustomerCombobox,
                          params: {
                            'customerCode': controller.receiverCustomerCode.value
                          },
                          // style: BccpAppTheme.textStyleBlue,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // FormInputText(
                        //   label: 'Cơ quan nhận / điểm phát khác',
                        //   onChange: (value) {
                        //     controller.deliveryPointName.value = value;
                        //   },
                        //   disabled: controller.deliveryPointCode.value != null,
                        //   value: controller.deliveryPointName.value,
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        FormInputText(
                          label: 'Địa chỉ nhận',
                          onChange: (value) {
                            controller.receiverAddress.value = value;
                            controller.receiverAddressError.value = '';
                          },
                          value: controller.receiverAddress.value,
                          error: controller.receiverAddressError.value,
                          important: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormInputText(
                          label: 'Điện thoại',
                          onChange: (value) {
                            controller.receiverTel.value = value;
                            controller.receiverTelError.value = '';
                          },
                          value: controller.receiverTel.value,
                          error: controller.receiverTelError.value,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormComBoBoxNetwork(
                          label: 'Tỉnh/TP',
                          value: controller.receiverProvinceCode.value,
                          error: controller.receiverProvinceCodeError.value,
                          onChange: (value) {
                            controller.onSelectProvince(
                                value != null ? value['value'] : null);
                            controller.receiverProvinceCodeError.value = '';
                          },
                          // style: BccpAppTheme.textStyleWhite,
                          hint: 'Chọn Tỉnh/TP',
                          apiUrl: BaseRepository.getProvinceCombobox,
                          params: {},
                          // style: BccpAppTheme.textStyleBlue,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormComBoBoxNetwork(
                          label: 'Quận/Huyện',
                          value: controller.receiverDistrictCode.value,
                          error: controller.receiverDistrictCodeError.value,
                          disabled:
                              controller.receiverProvinceCode.value == null ||
                                  controller.receiverProvinceCode.value.isEmpty,
                          onChange: (value) {
                            controller.onSelectDistrict(
                                value != null ? value['value'] : null);
                            controller.receiverDistrictCodeError.value = '';
                          },
                          // style: BccpAppTheme.textStyleWhite,
                          hint: 'Chọn Quận/Huyện',
                          apiUrl: BaseRepository.getDistrictCombox,
                          params: {
                            'provinceCode':
                                controller.receiverProvinceCode.value
                          },
                          // style: BccpAppTheme.textStyleBlue,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormComBoBoxNetwork(
                          disabled:
                              controller.receiverDistrictCode.value == null ||
                                  controller.receiverDistrictCode.value.isEmpty,
                          label: 'Phường xã',
                          value: controller.receiverCommuneCode.value,
                          error: controller.receiverCommuneCodeError.value,
                          onChange: (value) {
                            controller.receiverCommuneCode.value =
                                value != null ? value['value'] : null;
                            controller.receiverCommuneCodeError.value = '';
                          },
                          // style: BccpAppTheme.textStyleWhite,
                          hint: 'Chọn Phường xã',
                          apiUrl: BaseRepository.getCommuneCombobox,
                          params: {
                            'districtCode':
                                controller.receiverDistrictCode.value
                          },
                          // style: BccpAppTheme.textStyleBlue,
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // FormComBoBoxNetworkMulti(
                        //   label: 'Dịch vụ GTGT',
                        //   value: controller.vas.value,
                        //   onChange: (value) {
                        //     controller.vas.value = value;
                        //   },
                        //   // style: BccpAppTheme.textStyleWhite,
                        //   hint: 'Chọn Dịch vụ GTGT',
                        //   apiUrl: BaseRepository.getVasCombobox,
                        //   params: {},
                        //   // style: BccpAppTheme.textStyleBlue,
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        FormInputText(
                          label: 'Ghi chú',
                          onChange: (value) {
                            controller.note.value = value;
                            controller.noteError.value = '';
                          },
                          value: controller.note.value,
                          error: controller.noteError.value,
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // FormDateTimePicker(
                        //   label: 'Ngày giờ phát',
                        //   value: controller.sendingTime.value,
                        //   onChange: (value) {
                        //     controller.sendingTime.value = value;
                        //   },
                        //   type: FormDateTimePickerType.dateTime,
                        //   // style: BccpAppTheme.textStyleBlue,
                        // ),
                        SizedBox(
                          height: 10,
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
                        SizedBox(
                          height: 10,
                        ),
                        // IfWidget(
                        //   condition: controller.action.value == 'edit',
                        //   right: FormInputText(
                        //     label: 'Lý do cập nhật',
                        //     onChange: (value) {
                        //       controller.reasonModified.value = value;
                        //       print(value);
                        //     },
                        //     value: controller.reasonModified.value,
                        //     error: controller.reasonModifiedError.value,
                        //     important: true,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Obx(() => CustomButton(
                        text: controller.buttonText.value,
                        onPress: () {
                          controller.doPackage();
                        },
                      )),
                  IfWidget(
                    condition: controller.action.value == 'edit',
                    right: TextButton(
                      child: Text(
                        'Xóa bưu gửi',
                        style: BccpAppTheme.textStyleRed,
                      ),
                      onPressed: () {
                        controller.removePackage();
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
