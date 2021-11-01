import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:flutter/material.dart';

class AppListSelectBlock extends StatefulWidget {
  final List listValue;
  final dynamic value;
  final Function onChange;

  AppListSelectBlock({
    this.listValue = const [],
    this.value,
    this.onChange,
  });

  @override
  _AppListSelectBlockState createState() => _AppListSelectBlockState();
}

class _AppListSelectBlockState extends State<AppListSelectBlock> {
  Widget renderItem(Map item) {
    return GestureDetector(
      onTap: () {
        if (widget.onChange != null) {
          widget.onChange(item['value']);
        }
      },
      child: Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
        decoration: BoxDecoration(
          color: widget.value == item['value']
              ? mainColor.withAlpha(150)
              : mainColor.withAlpha(50),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 50),
          child: Center(
            child: Text(item['text']),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: 5, right: 5),
        children: [
          ...List.generate(widget.listValue.length,
              (index) => renderItem(widget.listValue[index]))
        ],
      ),
    );
  }
}
