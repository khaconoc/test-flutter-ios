import 'package:flutter/material.dart';

class IfWidget extends StatelessWidget {
  final bool condition;
  final Widget right;
  final Widget wrong;
  IfWidget({@required this.condition,@required this.right, this.wrong = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    return condition ? right : wrong;
  }
}
