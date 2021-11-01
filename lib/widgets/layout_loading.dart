import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:bccp_mobile_v2/widgets/page_frist_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LayoutLoading extends StatelessWidget {
  final bool isLoading;
  final bool isSubmit;
  final Widget child;
  final String message;

  LayoutLoading({
    this.isLoading = true,
    this.isSubmit = false,
    @required this.child,
    this.message = 'Vui lòng đợi...',
  });

  @override
  Widget build(BuildContext context) {
    return IfWidget(condition: isLoading, right: PageFirstLoadingWidget(), wrong: ModalProgressHUD(
      child: child,
      progressIndicator: _renderLoadingSpecial(),
      inAsyncCall: isSubmit,
    ),);
  }

  Container _renderLoading() {
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
            'Vui lòng đợi...',
            style: BccpAppTheme.textStyleWhite,
          )
        ],
      ),
    );
  }

  Widget _renderLoadingSpecial() {
    return Container(
      width: 230,
      height: 170,
      child: Stack(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.all(15),
              // width: MediaQuery.of(Get.overlayContext).size.width - 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 70),
                    child: Center(
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        border: Border.all(
                            width: 5, color: mainColor)),
                    child: Center(
                      child: SpinKitSpinningLines(color: mainColor, size: 60,),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
