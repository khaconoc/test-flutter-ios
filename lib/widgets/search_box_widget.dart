import 'package:bccp_mobile_v2/core/utils/util_color.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class SearchBoxWidget extends StatefulWidget {
  final Function(String value) onChange;
  final Function onMore;
  final bool isMore;

  SearchBoxWidget({@required this.onChange, this.onMore, this.isMore = false});

  @override
  _SearchBoxWidgetState createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  final textEditingController = TextEditingController();
  String tempValue = '';

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    textEditingController.addListener(() {
      /// so sanh voi gia tri hien co de loai bo event curmos hover
      if (textEditingController.text != tempValue) {
        widget.onChange(textEditingController.text);
      }
      setState(() {
        tempValue = textEditingController.text;
      });
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      // margin: EdgeInsets.only(bo),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.blueAccent),
        color: mainColor,
        // borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.blueAccent),
                // color: Colors.white.withAlpha(400),
                color: Colors.white.withAlpha(350),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: textEditingController,
                onChanged: (value) {
                  widget.onChange(value);
                },
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(
                    LineIcons.search,
                    color: Colors.white,
                  ),
                  suffixIcon: (textEditingController.text ?? '') == ''
                      ? null
                      : IconButton(
                          icon: Icon(LineIcons.close, size: 17,),
                          color: Colors.white,
                          onPressed: () {
                            textEditingController.text = '';
                          },
                        ),
                  border: InputBorder.none,
                  hintText: 'Nhập tìm kiếm',
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.blueAccent,
                  focusColor: Colors.red,
                ),
              ),
            ),
          ),
          IfWidget(
            condition: widget.onMore != null,
            right: IconButton(
              icon: Icon(Icons.filter_list),
              color: widget.isMore
                  ? UtilColor.getColorFromHex('FF0DFF00')
                  : Colors.white,
              onPressed: () {
                widget.onMore();
              },
            ),
          )
        ],
      ),
    );
  }
}
