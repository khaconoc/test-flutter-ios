import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppComboBoxLocal extends StatefulWidget {
  final Function onChange;
  final List<Map<String, dynamic>> listValue;
  final dynamic value;
  final String hint;
  final bool maxSize;
  final TextStyle style;

  AppComboBoxLocal({
    @required this.onChange,
    @required this.listValue,
    this.value,
    this.hint = '',
    this.maxSize = false,
    this.style = const TextStyle(),
  });

  @override
  _AppComboBoxLocalState createState() => _AppComboBoxLocalState();
}

class _AppComboBoxLocalState extends State<AppComboBoxLocal> {

  String text = '';
  dynamic value;

  @override
  void initState() {
    super.initState();
    khoiTao();
  }

  @override
  void didUpdateWidget(AppComboBoxLocal oldWidget) {
    if (oldWidget.value != widget.value) {
      khoiTao();
    }
    super.didUpdateWidget(oldWidget);
  }

  void khoiTao() {
    if(widget.value == null) {
      setValueControl(text: '', value: null);
      return;
    }
    Map<String, dynamic> temp = widget.listValue.firstWhere(
        (element) => element['value'] == widget.value,
        orElse: () => null);
    if (temp != null) {
      setState(() {
        text = temp['text'];
        value = temp['value'];
      });
    }
  }

  void setValueControl({String text, dynamic value}) {
    setState(() {
      text = text;
      value = value;
    });
  }

  removeValue() {
    if (widget.value is String) {
      widget.onChange(null);
      setValueControl(text: '', value: null);
    } else {
      widget.onChange(null);
      setValueControl(text: '', value: null);
    }
  }

  showBottomSheetSelect(BuildContext context) async {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (thisLowerContext, innerSetState) {
          return ViewSelect(
            value: widget.value,
            hint: widget.hint,
            listItem: widget.listValue,
            onChange: (value) {
              widget.onChange(value);
              setValueControl(text: value['text'], value: value['value']);
              Navigator.pop(context);
            },
            onUnSelect: removeValue,
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          showBottomSheetSelect(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value != null ? text : widget.hint,
              style: widget.style,
            ),
            IfWidget(
              condition: widget.maxSize,
              right: Spacer(),
            ),
            Icon(Icons.arrow_drop_down_rounded),
          ],
        ),
      ),
    );
  }
}

class ViewSelect extends StatefulWidget {

  final String hint;
  final Function onChange;
  final Function onUnSelect;
  final List<Map<String, dynamic>> listItem;
  final dynamic value;
  final Map params;

  ViewSelect({
    this.hint,
    this.onChange,
    this.listItem,
    this.value,
    this.params = const {},
    this.onUnSelect,
  });

  @override
  _ViewSelectState createState() => _ViewSelectState();
}

class _ViewSelectState extends State<ViewSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 2 / 3,
      decoration: BoxDecoration(
        // color: Colors.white,
      ),
      // color: Colors.amber,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 6,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(15))),
            child: Column(
              children: [
                // Container(
                //   width: 100,
                //   height: 6,
                //   decoration: BoxDecoration(
                //       color: Colors.grey,
                //       borderRadius: BorderRadius.circular(50)),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.hint,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                              text: widget.value != null ? 'Bỏ chọn' : 'Hủy',
                              style: BccpAppTheme.textStyleBlue,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  widget.onChange({'value': null, 'text': ''});
                                  // widget.onUnSelect();
                                  // Navigator.pop(context);
                                },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: widget.listItem.length,
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // widget.onChange(widget.listItem[index]['value']);
                        // Navigator.pop(context);
                        // setState(() {
                          widget.onChange(widget.listItem[index]);
                        // });
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(widget.listItem[index]['text']),
                              Spacer(),
                              IfWidget(
                                condition: widget.listItem[index]
                                ['value'] ==
                                    widget.value,
                                right: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
                  child: Divider(),
                  width: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
