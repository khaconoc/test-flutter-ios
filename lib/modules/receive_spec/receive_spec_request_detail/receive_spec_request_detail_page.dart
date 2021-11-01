import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/app_listview_loarmore.dart';
import 'package:bccp_mobile_v2/widgets/custom_button.dart';
import 'package:bccp_mobile_v2/widgets/form/form_combobox_network.dart';
import 'package:bccp_mobile_v2/widgets/form/form_datetime_picker.dart';
import 'package:bccp_mobile_v2/widgets/form/form_input_number.dart';
import 'package:bccp_mobile_v2/widgets/form/form_input_text.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:bccp_mobile_v2/widgets/layout/layout_structure.dart';
import 'package:bccp_mobile_v2/widgets/layout_loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'receive_spec_request_detail_controller.dart';

class ReceiveSpecRequestDetailPage
    extends GetView<ReceiveSpecRequestDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.titleText.value ?? '')),
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.arrow_upward))],
      ),
      body: Obx(() => LayoutLoading(
        isLoading: controller.isLoading.value,
        isSubmit: controller.isSubmit.value,
        child: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: LayoutStructure(
              // isLoading: controller.isLoading.value,
              child: Column(
                children: [
                  // InfoDetailUI(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        FormDateTimePicker(
                          label: 'Ngày chấp nhận',
                          value: controller.approvedDate.value,
                          error: controller.approvedDateError.value,
                          onChange: (value) {
                            controller.approvedDate.value = value;
                            controller.approvedDateError.value = '';
                          },
                          type: FormDateTimePickerType.dateTime,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormComBoBoxNetwork(
                          label: 'Cơ quan gửi',
                          value: controller.senderCustomerCode.value,
                          error: controller.senderCustomerCodeError.value,
                          onChange: (value) {
                            controller.onChangeCustomer(
                                value != null ? value['value'] : '');
                            controller.senderCustomerCodeError.value = '';
                          },
                          // style: BccpAppTheme.textStyleWhite,
                          hint: 'Chọn khách hàng',
                          apiUrl: BaseRepository.getCustomerCombobox,
                          params: {},
                          important: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormInputText(
                          onChange: (value) {
                            controller.senderAddress.value = value;
                            controller.senderAddressError.value = '';
                          },
                          value: controller.senderAddress.value,
                          error: controller.senderAddressError.value,
                          label: 'Địa chỉ',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormInputText(
                          onChange: (value) {
                            controller.senderTel.value = value;
                            controller.senderTelError.value = '';
                          },
                          value: controller.senderTel.value,
                          error: controller.senderTelError.value,
                          label: 'Điện thoại',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormComBoBoxNetwork(
                          label: 'Đối tượng gửi',
                          value: controller.senderObjectID.value,
                          error: controller.senderObjectIDError.value,
                          onChange: (value) {
                            controller.senderObjectID.value =
                            value != null ? value['value'] : null;
                            controller.senderObjectIDError.value = '';
                          },
                          // style: BccpAppTheme.textStyleWhite,
                          hint: 'Chọn đối tượng gửi',
                          apiUrl: BaseRepository.getCustomerObjectCombobox,
                          params: {
                            "allowReceiver": false,
                            "allowSend": true,
                            "customerCode": "--"
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormInputText(
                          onChange: (value) {
                            controller.requestContent.value = value;
                            controller.requestContentError.value = '';
                          },
                          value: controller.requestContent.value,
                          error: controller.requestContentError.value,
                          label: 'Nội dung yêu cầu',
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FormInputText(
                          onChange: (value) {
                            controller.approvedContent.value = value;
                            controller.approvedContentError.value = '';
                          },
                          value: controller.approvedContent.value,
                          error: controller.approvedContentError.value,
                          label: 'Nội dung xác nhận',
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: FormInputNumber(
                        //         onChange: (value) {
                        //           controller.itemNumber.value = value;
                        //         },
                        //         value: controller.itemNumber.value,
                        //         disabled: false,
                        //         label: 'Tổng SL khách hàng gửi',
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Expanded(
                        //       child: FormInputNumber(
                        //         onChange: (value) {
                        //           controller.itemNumberSecret.value = value;
                        //         },
                        //         value: controller.itemNumberSecret.value,
                        //         disabled: false,
                        //         label: 'SL mật khách hàng gửi',
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: FormInputNumber(
                                onChange: (value) {
                                  controller.itemNumberPostman.value = value;
                                  controller.itemNumberPostmanError.value = '';
                                },
                                value: controller.itemNumberPostman.value,
                                error: controller.itemNumberPostmanError.value,
                                label: 'Tổng SL bưu tá nhận',
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: FormInputNumber(
                                onChange: (value) {
                                  controller.itemNumberSecretPostman.value =
                                      value;
                                  controller.itemNumberSecretPostmanError.value = '';
                                },
                                value:
                                controller.itemNumberSecretPostman.value,
                                error:
                                controller.itemNumberSecretPostmanError.value,
                                label: 'SL mật bưu tá nhận',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tìm thấy ${controller.count.value} bưu gửi'),
                        IfWidget(condition: controller.action.value != 'confirm', right: RichText(
                          text: TextSpan(
                            text: '+ Thêm bưu gửi',
                            style: TextStyle(color: mainColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                controller.doPackageNormal(null, null, null);
                              },
                          ),
                        ),),
                      ],
                    ),
                  ),
                  AppListViewLoadMore(
                    onLoadMore: () {
                      controller.onLoadMorePackage();
                    },
                    onPress: (requestId, itemId, requestDetailId) {
                      controller.doPackageNormal(
                          requestId, itemId, requestDetailId);
                    },
                    listValue: controller.listPackage.value,
                    isEmpty: controller.emptyData.value,
                  ),
                  CustomButton(
                    // icon: LineIcons.check,
                    isLoading: controller.isLoading.value,
                    text: controller.textButton.value,
                    onPress: () {
                      // context.read<PostageDetailScope>().onAcceptBuuGuiThuong(context);
                      controller.onUpdate();
                    },
                    margin: EdgeInsets.all(0),
                    borderRadius: 0,
                  )
                  // ReceiveRequestDetailTabNormalWidget()
                ],
              ),
            ),
          ),
        ),
      ),))
    );
  }
}
