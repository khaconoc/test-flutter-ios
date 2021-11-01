import 'package:bccp_mobile_v2/widgets/app_combobox_local.dart';
import 'package:bccp_mobile_v2/widgets/custom_button.dart';
import 'package:bccp_mobile_v2/widgets/form/form_combobox_local.dart';
import 'package:bccp_mobile_v2/widgets/form/form_input_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'receiver_real_add_controller.dart';

class ReceiverRealAddPage extends GetView<ReceiverRealAddController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm văn thư'),
        leading: IconButton(
          icon: Icon(LineIcons.close, color: Colors.black,),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Obx(() => Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  FormInputText(
                    onChange: (value) {
                      controller.receiverFullName.value = value;
                      controller.receiverFullNameError.value = '';
                    },
                    value: controller.receiverFullName.value,
                    error: controller.receiverFullNameError.value,
                    label: 'Họ và tên',
                  ),
                  SizedBox(height: 10,),
                  FormInputText(
                    onChange: (value) {
                      controller.receiverPhone.value = value;
                      controller.receiverPhoneError.value = '';
                    },
                    value: controller.receiverPhone.value,
                    error: controller.receiverPhoneError.value,
                    label: 'Số điện thoại',
                  ),
                  SizedBox(height: 10,),
                  FormInputText(
                    onChange: (value) {
                      controller.receiverDepartment.value = value;
                      controller.receiverDepartmentError.value = '';
                    },
                    value: controller.receiverDepartment.value,
                    error: controller.receiverDepartmentError.value,
                    label: 'Phòng ban',
                  ),
                  SizedBox(height: 10,),
                  FormComBoBoxLocal(
                    onChange: (value) {
                      controller.receiverPosition.value = value != null ? value['value'] : null;
                      controller.receiverPositionError.value = '';
                    },
                    value: controller.receiverPosition.value,
                    listItem:  [
                      { 'value': '1', 'text': 'Văn thư' },
                      { 'value': '2', 'text': 'Bảo vệ' },
                      { 'value': '3', 'text': 'Cảnh vệ' },
                      { 'value': '4', 'text': 'Thư ký' },
                      { 'value': '5', 'text': 'Trợ lý' },
                      { 'value': '-1', 'text': 'Khác' }
                    ],
                    label: 'Chức vụ',
                  ),
                ],
              ),
            ),
            CustomButton(
              onPress: () {
                controller.onSubmit();
              },
              text: 'Ghi',
              isLoading: controller.isSubmit.value,
            )
          ],
        ),)
      ),
    );
  }
}