import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:flutter/material.dart';

class FormTimePicker extends StatefulWidget {
  final TimeOfDay value;
  final TextStyle style;
  final Function onChange;
  final String label;
  final bool important;

  FormTimePicker({
    this.value,
    this.style = const TextStyle(),
    this.onChange,
    this.label = '',
    this.important = false,
  });

  @override
  _FormTimePickerState createState() => _FormTimePickerState();
}

class _FormTimePickerState extends State<FormTimePicker> {

  @override
  void initState() {
    super.initState();
  }

  String twoChar(int value) {
    if (value < 10) {
      return '0$value';
    }
    return value.toString();
  }

  pickTime(BuildContext context) async {
    final TimeOfDay result = await showTimePicker(
      context: context, initialTime: widget.value,
    );
    if (result != null) {
      widget.onChange(result);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
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
          InkWell(
            onTap: () {
              pickTime(context);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: mainColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text(widget.value == null ? '__:__' : '${twoChar(widget.value.hour)}:${twoChar(widget.value.minute)}',
                      style: widget.style,),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
