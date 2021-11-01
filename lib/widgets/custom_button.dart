import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

enum CustomButtonShape { circle, rectangle }

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Function onPress;
  final Color color, textColor;
  final Gradient backgroundGradient;
  final bool disable;
  final bool hidden;
  final bool isLoading;
  final Widget prefix;
  final Widget suffix;
  final Color colorIcon;
  final EdgeInsets margin;
  final bool shadow;
  final double borderRadius;
  final double width;
  final double height;

  final List<BoxShadow> _listBoxShadow = [];

  CustomButton({
    Key key,
    this.text = '',
    this.textStyle = BccpAppTheme.buttonTextStyle,
    this.onPress,
    this.color = mainColor,
    this.textColor = Colors.white,
    this.backgroundGradient = BccpAppTheme.buttonTheme_mainGradient,
    this.disable = false,
    this.shadow = false,
    this.hidden = false,
    this.isLoading = false,
    this.prefix,
    this.suffix,
    this.colorIcon = Colors.white,
    this.margin = const EdgeInsets.all(5),
    this.borderRadius = 5,
    this.height,
    this.width,
  }) : super(key: key) {
    if (shadow) {
      _listBoxShadow.add(BoxShadow(
        color: Colors.black54.withAlpha(300),
        spreadRadius: 1,
        blurRadius: 7,
        offset: Offset(2, 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return this.hidden
        ? Container()
        : Container(
            margin: margin,
            // width: size.width * 0.8,
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: _listBoxShadow,
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  elevation: MaterialStateProperty.all<double>(0.0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      // side: BorderSide(color: Colors.red)
                    ),
                  ),
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
              onPressed: isLoading ? null : onPress,
              child: Ink(
                decoration: BoxDecoration(
                    gradient: backgroundGradient,
                    borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Container(
                  // padding: EdgeInsets.symmetric(vertical: 15),
                  height: height ?? 50,
                  // color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading
                          ? SizedBox(
                              child: SpinKitFadingCircle(
                                color: textColor,
                                size: 20,
                              ),
                            )
                          : Row(
                              children: [
                                prefix == null ? Container() : prefix,
                                // SizedBox(
                                //   width: 5,
                                // ),
                                Text(
                                  text,
                                  style:
                                      TextStyle(color: textColor, fontSize: 18),
                                ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                suffix == null ? Container() : suffix,
                              ],
                            )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
