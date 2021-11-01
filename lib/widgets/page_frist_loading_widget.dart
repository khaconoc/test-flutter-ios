import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PageFirstLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _renderCode(),
            _renderLabel(),
            _renderInfo(),
            _renderInfo(),
            _renderInfo(),
            _renderInfo(),
            _renderLabel(),
            _renderCode(),
            _renderLabel(),
            _renderCode(),
            _renderLabel(),
            _renderCode(),
            _renderInfo(),
            _renderInfo(),
          ],
        ),
      ),
    );
  }

  Container _renderCode() {
    return Container(
      margin: EdgeInsets.all(20),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Container _renderLabel() {
    return Container(
      margin: EdgeInsets.all(5),
      height: 20,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _renderInfo() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(5),
            height: 20,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.all(5),
            height: 20,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        )
      ],
    );
  }
}
