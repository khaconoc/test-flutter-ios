import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class FormInputText extends StatefulWidget {
  /// nguyên lý hoạt động:
  /// step 1: control sẽ nhận vào giá trị value để set mặc định giá trị cho control
  /// step 2: khi người dùng gõ phím thì control sẽ emit value ra widget cha
  /// step 3: widget cha sẽ set giá trị vào biến được lưu giữ ở widget cha
  /// step 4: khi biến ở widget cha thay đổi giá trị thì didUpdateState của control được gọi
  ///         nếu value biến widget cha khác giá trị control thì update giá trị control
  /// step 5: nếu người dùng click button clear thì quay lại step 2



  /// tiêu đề hiển thị trên control
  final String label;
  /// khi thay đổi giá trị sẽ đẩy sự kiện onchange ra widget cha
  final Function onChange;
  /// value nhận vào để hiển thị lên control
  final String value;
  /// disable
  final bool disabled;
  /// hint
  final String hintText;
  /// important: hiển thị dấu (*) bắt buộc
  final bool important;
  /// hiển thị lỗi nếu error khác ''
  final String error;

  final int maxLines;

  final dynamic defaultValue;

  /// constructor
  FormInputText({
    this.label = '',
    @required this.onChange,
    this.value = '',
    this.disabled = false,
    this.hintText,
    this.important = false,
    this.error = '',
    this.defaultValue,
    this.maxLines = 1,
  });

  @override
  _FormInputTextState createState() => _FormInputTextState();
}

class _FormInputTextState extends State<FormInputText> {
  /// textEditingController điều khiển thay đổi text của TextField
  /// (*) Flutter chỉ có thể thay đổi text của TextField bằng textEditingController
  TextEditingController textEditingController = new TextEditingController();

  /// style của text khi control bị disable
  TextStyle disableStyle = TextStyle(color: Colors.grey);

  @override
  void initState() {
    super.initState();

    /// lắng nghe sự kiện khi gõ text
    /// nếu text hiện tại khác text value nhận vào thì mới đẩy sự kiện onchange
    /// dành cho trường hợp xóa hết rồi mà ấn nút xóa sẽ không làm gì
    textEditingController.addListener(() {
      if (textEditingController.text != widget.value) {
        widget.onChange(textEditingController.text);
      }
    });

    /// gán giá trị control bằng giá trị nhận vào
    textEditingController.text = widget.value;
  }

  @override
  void didUpdateWidget(FormInputText oldWidget) {
    super.didUpdateWidget(oldWidget);
    /// mỗi khi value nhận vào thay đổi
    /// thì kiểm tra nếu khác giá trị hiện tại thì thay đổi giá trị hiện tại
    String temp = widget.value == null ? '' : widget.value;
    if (temp != textEditingController.text) {
      textEditingController.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// hiển thị label text nếu label khác rổng
          IfWidget(
            condition: widget.label != '',
            right: Padding(
              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
              // child: Text(
              //   widget.label,
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),
              child: RichText(
                text: TextSpan(
                    text: widget.label,
                    style: TextStyle(color: Colors.black),
                    /// nếu important thì hiển dấu (*) bắt buộc
                    children: [
                      widget.important
                          ? TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.redAccent),
                            )
                          : TextSpan()
                    ]),
              ),
            ),
          ),
          /// hiển thị control input
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                // color: mainColor.withAlpha(50),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Expanded(
                  /// nếu control disable thì gắn style = style disabled
                  child: TextField(
                    style: widget.disabled ? disableStyle : null,
                    maxLines: widget.maxLines,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      fillColor: widget.disabled
                          ? Colors.grey.withAlpha(50)
                          : mainColor.withAlpha(20),
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 10),
                      // isDense: true,
                      enabled: !widget.disabled,
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.yellow),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          /// nếu control có biến lỗi thì vẽ border màu đỏ
                          color: (widget.error.isNotEmpty && !widget.disabled)
                              ? Colors.redAccent
                              : Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      // errorBorder: InputBorder.none,
                      // disabledBorder: InputBorder.none,
                      /// nếu control đang có giá trị thì hiển thị nút clear
                      suffixIcon: widget.disabled || widget.value == ''
                          ? null
                          : SizedBox(
                              height: 5,
                              width: 5,
                              child: IconButton(
                                icon: Icon(
                                  LineIcons.close,
                                  size: 15,
                                ),
                                onPressed: () {
                                  // widget.onChange('');
                                  textEditingController.text = '';
                                },
                              ),
                            ),
                    ),
                    controller: textEditingController,
                  ),
                ),
              ],
            ),
          ),
          /// hiển thị thông báo lỗi dưới chân control
          IfWidget(
            /// kiểm tra có lỗi và control đang không disable thì mới hiển thị lỗi
            condition: widget.error.isNotEmpty && !widget.disabled,
            right: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                widget.error,
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
