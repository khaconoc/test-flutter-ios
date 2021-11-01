import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final Widget child;
  final Widget appBar;

  ContainerWidget({this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: child,
        ),
      ),
    );
  }
}
