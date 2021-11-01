import 'package:bccp_mobile_v2/core/services/dialog_service.dart';
import 'package:bccp_mobile_v2/modules/login/login_controller.dart';
import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:bccp_mobile_v2/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    var keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      // backgroundColor: Colors.pinkAccent,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bccp_background.png'),
                  fit: BoxFit.cover),
            ),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.toggleAppLanguage();
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              // border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(100),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black54.withAlpha(300),
                                    blurRadius: 7,
                                    spreadRadius: 1,
                                    offset: Offset(1, 1))
                              ]),
                          child: Row(
                            children: [
                              Image.asset(
                                controller.localizationExtService.appLanguage
                                            .value ==
                                        'vi'
                                    ? 'assets/images/icon_vi.png'
                                    : 'assets/images/icon_en.png',
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(controller
                                  .localizationExtService.getAppLanguage)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Image.asset('assets/images/logo.png', height: 50, width: 70,),
                  Text(
                    'login'.tr,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: Colors.blueAccent),
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(100),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black54.withAlpha(300),
                                      blurRadius: 7,
                                      spreadRadius: 1,
                                      offset: Offset(1, 1))
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomInputText(
                                  icon: LineIcons.user,
                                  hintText: 'hintTextInputUsername'.tr,
                                  onChange: (value) {
                                    controller.setUser(value);
                                  },
                                ),
                                Divider(),
                                Obx(() => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 40.0),
                                      child: CustomInputText(
                                        icon: LineIcons.key,
                                        focusNode: controller.focusPass,
                                        hintText: 'hintTextInputPassword'.tr,
                                        obscureText:
                                            controller.isVisibility.value,
                                        suffix: (!controller
                                                    .pass.value.isBlank &&
                                                controller.showVisibility.value)
                                            ? IconButton(
                                                icon: Icon(controller
                                                        .isVisibility.value
                                                    ? Icons.visibility
                                                    : Icons.visibility_off),
                                                onPressed: () {
                                                  controller.toggleVisibility();
                                                },
                                              )
                                            : null,
                                        onChange: (value) {
                                          controller.setPass(value);
                                        },
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Positioned.fill(
                          right: 0,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: CustomButton(
                              backgroundGradient:
                                  BccpAppTheme.buttonTheme_primaryGradient,
                              width: 70,
                              height: 70,
                              borderRadius: 70,
                              shadow: true,
                              prefix: Icon(
                                LineIcons.arrow_right,
                                size: 30,
                                color: Colors.white,
                              ),
                              onPress: () {
                                controller.login();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'forgotPassword'.tr,
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                            DialogService.alert(title: 'Quên mật khẩu',message: 'Vui lòng liên hệ với quản trị viên');
                              // DialogService.showSnackBarSuccess(context, "lưu dữ liệu thành công", StatusSnackBar.success);
                            },
                        ),
                        // TextSpan(text: ' world!'),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Obx(() => Text(
                    'Copyright© 2021 - bưu cục chuyển phát - v${controller.version.value}',
                    style: TextStyle(color: Colors.white),
                  )),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomInputText extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final Function onChange;
  final bool obscureText;
  final Widget suffix;
  final FocusNode focusNode;

  const CustomInputText({
    Key key,
    this.icon,
    this.hintText,
    this.onChange,
    this.obscureText = false,
    this.suffix,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: hintText,
        prefixIcon: Icon(icon),
        suffixIcon: suffix,
      ),
      onChanged: onChange,
    );
  }
}
