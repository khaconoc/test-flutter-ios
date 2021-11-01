import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LazyLoadProgressIndicator extends StatelessWidget {
  final bool isLoading;
  const LazyLoadProgressIndicator({
    Key key,
    this.isLoading
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 0.0,
          child: SpinKitFadingCircle(color: Colors.grey, size: 15,),
        ),
      ),
    );
  }
}
