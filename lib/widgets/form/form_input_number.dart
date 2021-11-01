import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class FormInputNumber extends StatefulWidget {
  final String label;
  final Function onChange;
  final int value;
  final bool disabled;
  final bool important;
  final String error;
  final dynamic defaultValue;

  FormInputNumber({
    this.label = '',
    @required this.onChange,
    this.value,
    this.disabled = false,
    this.important = false,
    this.error = '',
    this.defaultValue,
  });

  @override
  _FormInputNumberState createState() => _FormInputNumberState();
}

class _FormInputNumberState extends State<FormInputNumber> {
  TextEditingController textEditingController = new TextEditingController();
  TextStyle disableStyle = TextStyle(color: Colors.grey);

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(() {
      if (textEditingController.text != widget.value.toString()) {
        widget.onChange(int.tryParse(textEditingController.text));
      }
    });
    textEditingController.text = widget.value == null ? '' :widget.value.toString();
  }

  @override
  void didUpdateWidget(FormInputNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    String temp = widget.value == null ? "" : widget.value.toString();
    if (temp != textEditingController.text) {
      textEditingController.text = widget.value == null ? '' :widget.value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                // color: mainColor.withAlpha(50),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: widget.disabled ? disableStyle : null,
                    decoration: InputDecoration(
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
                          color: (widget.error != '' && widget.error != '' && !widget.disabled)
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

                      suffixIcon: widget.disabled || textEditingController.text == ''
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
                                  // widget.onChange(widget.defaultValue);
                                  textEditingController.text = '';
                                },
                              ),
                            ),
                    ),
                    controller: textEditingController,
                    // onChanged: (value) {
                    //   if (widget.onChange != null) widget.onChange(value);
                    // },
                  ),
                ),
              ],
            ),
          ),
          IfWidget(
            condition: widget.error != null && widget.error != '' && !widget.disabled,
            right: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                widget.error??'',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
