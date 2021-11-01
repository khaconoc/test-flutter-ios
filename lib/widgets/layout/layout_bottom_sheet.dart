import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LayoutBottomSheet extends StatelessWidget {
  final double height;
  final Widget child;
  final String title;
  final String textActionRight;
  final Function onPressActionRight;

  LayoutBottomSheet({
    this.height,
    this.child,
    this.title,
    this.textActionRight,
    this.onPressActionRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 2 / 3,
      decoration: BoxDecoration(
          // color: Colors.white,
          ),
      // color: Colors.amber,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 6,
            decoration: BoxDecoration(
                color: Colors.white.withAlpha(200),
                borderRadius: BorderRadius.circular(50)),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          title ?? '',
                          style: TextStyle(
                            // fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: IfWidget(
                        condition: textActionRight != null,
                        right: Align(
                          alignment: Alignment.centerRight,
                          child: RichText(
                            text: TextSpan(
                                text: textActionRight??'',
                                style: BccpAppTheme.textStyleBlue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if(onPressActionRight != null) {
                                      onPressActionRight();
                                    }
                                    Navigator.pop(context);
                                  }),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}
