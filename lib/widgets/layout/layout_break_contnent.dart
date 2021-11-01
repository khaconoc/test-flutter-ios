import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:flutter/material.dart';

class LayoutBreakContent extends StatelessWidget {
  final String title;

  const LayoutBreakContent({Key key, this.title = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: mainColor, width: 0.5),
                          ),
                        ),
                      ),
                      Container(height: 9,)
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}