import 'package:bccp_mobile_v2/core/utils/helpers.dart';
import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  final Color color;
  final String text;
  TagWidget({@required this.color,@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: Text(
        text??'',
        style: TextStyle(fontSize: 10, color: Colors.white),
      ),
    );
  }
}
