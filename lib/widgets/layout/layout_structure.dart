import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../if_widget.dart';

enum ScoreWidgetStatus { HIDDEN, BECOMING_VISIBLE, BECOMING_INVISIBLE }

class LayoutStructure extends StatefulWidget {
  final bool isLoading;
  final Widget child;

  LayoutStructure({this.isLoading = false, @required this.child});

  @override
  _LayoutStructureState createState() => _LayoutStructureState();
}

class _LayoutStructureState extends State<LayoutStructure>
    with TickerProviderStateMixin {
  double animationOpacity = 0.0;
  AnimationController animationController;
  CurvedAnimation curvedAnimation;
  ScoreWidgetStatus _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;

  @override
  void initState() {
    animationController = AnimationController(
      duration: new Duration(milliseconds: 500),
      vsync: this,
    );
    curvedAnimation = new CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutQuad,
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
      }
    });
    curvedAnimation.addListener(() {
      setState(() {});
    });
    super.initState();
    if (widget.isLoading) {
      animationController.forward(from: 0.0);
    }
  }

  @override
  void didUpdateWidget(LayoutStructure oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading) {
      animationController.forward(from: 0.0);
    }
    if (!widget.isLoading) {
      animationController.reverse(from: 1.0);
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    curvedAnimation.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Container(
          // color: Colors.yellow.shade50,
          child: Stack(
            children: [
              widget.child,
              IfWidget(
                condition: widget.isLoading && curvedAnimation.value > 0,
                right: Positioned.fill(
                  child: Container(
                    color: mainColor.withAlpha(50),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Opacity(
                        opacity: curvedAnimation.value,
                        child: Container(
                          padding: EdgeInsets.only(top: 200),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
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
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
