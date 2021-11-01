import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListShortFirstLoadingWidget extends StatelessWidget {
  final int count;
  ListShortFirstLoadingWidget({this.count = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(count, (index) => _renderItem())
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

  Widget _renderItem() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Row(
                children: [
                  Expanded(child: Container(
                    margin: EdgeInsets.all(5),
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )),
                  Expanded(child: Container(
                    margin: EdgeInsets.all(5),
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
