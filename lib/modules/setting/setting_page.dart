import 'package:bccp_mobile_v2/modules/setting/setting_controller.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/app_combobox_local.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class SettingPage extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setting'.tr),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              ListTile(
                minLeadingWidth: 10,
                leading: Icon(
                  LineIcons.language,
                  color: Colors.red,
                ),
                title: Text(
                  'language'.tr,
                  style: TextStyle(
                    // fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
                subtitle: Text('Ngôn ngữ ứng dụng'),
                trailing: Obx(() => SizedBox(
                      // width: 200,
                      child: AppComboBoxLocal(
                        onChange: (value) {
                          // controller.test.value = value;
                          controller.onChangeLanguage(value['value']);
                        },
                        listValue: [
                          {'text': 'Việt Nam', 'value': 'vi'},
                          {'text': 'English', 'value': 'en'},
                        ],
                        value: controller.appLanguage.value,
                        hint: 'Ngôn ngữ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        maxSize: false,
                      ),
                    )),
              ),
              Divider(indent: 50,endIndent: 50,),
              ListTile(
                minLeadingWidth: 10,
                leading: Icon(
                  LineIcons.key,
                  color: Colors.red,
                ),
                title: Text(
                  'Duy trì đăng nhập',
                  style: TextStyle(
                    // fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
                subtitle: Text('Sẽ không phải đăng nhập lại khi không sủ dụng ứng dụng quá lâu'),
                trailing: Obx(
                  () => CupertinoSwitch(
                    onChanged: (value) {
                      controller.toggleKeepLogin(value);
                    },
                    activeColor: mainColor,
                    value: controller.keepLogin.value,
                  ),
                ),
              ),
              Divider(indent: 50,endIndent: 50,),
              ListTile(
                minLeadingWidth: 10,
                leading: Icon(
                  LineIcons.key,
                  color: Colors.red,
                ),
                title: Text(
                  'Chế độ nhà phát triển',
                  style: TextStyle(
                    // fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
                subtitle: Text('Ứng dụng sẽ hiển thị dữ liệu truyền tải lên server'),
                trailing: Obx(
                      () => CupertinoSwitch(
                    onChanged: (value) {
                      controller.toggleDevMode(value);
                    },
                    activeColor: mainColor,
                    value: controller.devMode.value,
                  ),
                ),
              ),
              Divider(indent: 50,endIndent: 50,),
              ListTile(
                minLeadingWidth: 10,
                leading: Icon(
                  LineIcons.arrow_circle_o_down,
                  color: Colors.red,
                ),
                title: Text(
                  'Kiểm tra cập nhật',
                  style: TextStyle(
                    // fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
                onTap: () {
                  controller.onCheckUpdate();
                },
                trailing: IfWidget(condition: controller.configServerService.isHasNerVersion.value,
                right: Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),)
                // subtitle: Text('Kiểm tra cập nhật'),
              ),
              Divider(indent: 50,endIndent: 50,),
              ListTile(
                minLeadingWidth: 10,
                leading: Icon(
                  LineIcons.sign_out,
                  color: Colors.red,
                ),
                title: Text(
                  'logout'.tr,
                  style: TextStyle(
                    // fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
                onTap: () {
                  controller.onLogout();
                },
              ),
              Spacer(),
              Obx(() => Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                        'Copyright© 2021 - bưu cục chuyển phát - v${controller.version.value}'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
