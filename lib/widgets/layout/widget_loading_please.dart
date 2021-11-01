import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WidgetLoadingPlease extends StatelessWidget {

  final String message;
  WidgetLoadingPlease({this.message = 'Vui lòng đợi...'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitWave(
            color: Colors.white,
            size: 25,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            message??'',
            style: BccpAppTheme.textStyleWhite,
          )
        ],
      ),
    );
  }
}
