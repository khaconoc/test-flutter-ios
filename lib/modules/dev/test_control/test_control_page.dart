import 'package:bccp_mobile_v2/data/repositories/base_repository.dart';
import 'package:bccp_mobile_v2/widgets/app_combobox_network.dart';
import 'package:bccp_mobile_v2/widgets/app_listview.dart';
import 'package:bccp_mobile_v2/widgets/custom_button.dart';
import 'package:bccp_mobile_v2/widgets/form/form_datetime_picker.dart';
import 'package:bccp_mobile_v2/widgets/form/form_input_number.dart';
import 'package:bccp_mobile_v2/widgets/form/form_input_text.dart';
import 'package:bccp_mobile_v2/widgets/layout/layout_structure.dart';
import 'package:bccp_mobile_v2/widgets/search_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'test_control_controller.dart';

class TestControlPage extends GetView<TestControlController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dev'),
      ),
      body: SafeArea(
        child: Obx(() =>
            Column(
              children: [
                FormInputText(
                  onChange: (value) {
                    controller.formObs['customer'] = value;
                  },
                  value: controller.formObs['customer'],
                ),
                FormInputNumber(
                  onChange: (value) {
                    controller.formObs['age'] = value;
                  },
                  value: controller.formObs['age'],
                ),
                FormDateTimePicker(
                  onChange: (value) {
                    controller.formObs['birthDate'] = value;
                  },
                  value: controller.formObs['birthDate'],
                ),
                CustomButton(
                  text: 'Change form value',
                  onPress: () {
                    controller.formObs['customer'] = 'change roi nha';
                  },
                )
              ],
            )
        ),
      ),
    );
  }
}
