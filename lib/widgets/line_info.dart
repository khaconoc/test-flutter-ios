import 'package:flutter/material.dart';

class LineInfo extends StatelessWidget {
  final String title;
  final String value;
  final Function onPress;

  LineInfo({this.title = '', this.value = '', this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(
        // border: Border(
        //   bottom: BorderSide(
        //     color: Colors.grey,
        //     width: 0.5,
        //   ),
        // ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            Text(title),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: InkWell(
                onTap: onPress,
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: onPress == null ? null : Colors.blueAccent),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}