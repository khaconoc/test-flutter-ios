import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:line_icons/line_icons.dart';

class FormDateTimePicker extends StatefulWidget {
  final DateTime value;
  final TextStyle style;
  final Function onChange;
  final String label;
  final bool important;
  final bool disabled;
  final FormDateTimePickerType type;

  /// hiển thị lỗi
  final String error;

  FormDateTimePicker(
      {this.value,
      this.style = const TextStyle(),
      this.onChange,
      this.label = '',
      this.error = '',
      this.important = false,
      this.disabled = false,
      this.type = FormDateTimePickerType.date}) {
    if (this.value == null) {}
  }

  @override
  _FormDateTimePickerState createState() => _FormDateTimePickerState();
}

class _FormDateTimePickerState extends State<FormDateTimePicker> {
  LocaleType currentLocal = LocaleType.vi;

  // DateTime value;

  Future<DateTime> pickDate(BuildContext context) async {
    var rs = DatePicker.showDatePicker(context,
        showTitleActions: true,
        currentTime:
            widget.value != null ? widget.value.toLocal() : DateTime.now(),
        locale: currentLocal);
    return rs;
  }

  Future<DateTime> pickTime(BuildContext context) async {
    var rs = await DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      locale: currentLocal,
      showSecondsColumn: false,
      onConfirm: (date) {
        // return date;
      },
      currentTime:
          widget.value != null ? widget.value.toLocal() : DateTime.now(),
    );
    return rs;
  }

  onPick(BuildContext context) async {
    switch (widget.type) {
      case FormDateTimePickerType.date:
        var date = await pickDate(context);
        if (date != null) {
          widget.onChange(date.toUtc());
        }
        break;
      case FormDateTimePickerType.time:
        var time = await pickTime(context);
        if (time != null) {
          widget.onChange(time.toUtc());
        }
        break;
      default:
        var date = await pickDate(context);
        if (date != null) {
          var time = await pickTime(context);
          if (time != null) {
            print(date);
            print(time);
            var dateChoose = DateTime(
                date.year, date.month, date.day, time.hour, time.minute);
            print(dateChoose);
            widget.onChange(dateChoose.toUtc());
            // setState(() => value = dateChoose);
          }
        }
    }
  }

  String _renderTime({DateTime time, FormDateTimePickerType type}) {
    var value = widget.value == null ? null : widget.value.toLocal();
    switch (type) {
      case FormDateTimePickerType.date:
        return value != null
            ? '${towChar(value.day)}/${towChar(value.month)}/${value.year}'
            : '__/__/____';
        break;
      case FormDateTimePickerType.time:
        return value != null
            ? '${towChar(value.hour)}:${towChar(value.minute)}'
            : '__:__';
        break;
      default:
        return value != null
            ? '${towChar(value.day)}/${towChar(value.month)}/${value.year}   ${towChar(value.hour)}:${towChar(value.minute)}'
            : '__/__/____   __:__';
    }
  }

  void onClear() {
    widget.onChange(null);
  }

  String towChar(int value) {
    return value >= 10 ? '$value' : '0$value';
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
            onTap: !widget.disabled
                ? () {
                    onPick(context);
                  }
                : null,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: widget.disabled
                      ? Colors.grey.withAlpha(50)
                      : mainColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                  border: (widget.error.isNotEmpty && !widget.disabled)
                      ? Border.all(color: Colors.redAccent)
                      : null),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      _renderTime(type: widget.type, time: widget.value),
                      style: widget.style,
                    ),
                  ),
                  IfWidget(
                    condition: !widget.disabled && widget.value != null,
                    right: IconButton(
                      icon: Icon(LineIcons.close, size: 15),
                      onPressed: () {
                        onClear();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          /// render lỗi nếu có
          IfWidget(
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

enum FormDateTimePickerType { date, time, dateTime }

class DateTimeValue {}
