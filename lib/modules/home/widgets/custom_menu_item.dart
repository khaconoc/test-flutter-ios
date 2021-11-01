import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/theme/text_theme.dart';
import 'package:flutter/material.dart';

class CustomContainerMenu extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  CustomContainerMenu(this.text, this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        width: 300,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: mainColor),
        ),
        child: FlatButton(
          splashColor: mainColor,
          onPressed: this.callback,
          child: Center(
              child: Text(
                this.text,
                // style: ,
              )),
        ));
  }
}