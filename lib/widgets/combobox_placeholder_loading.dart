import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ComboboxPlaceHolderLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _renderItem(),
            _renderItem(),
            _renderItem(),
            _renderItem(),
            _renderItem(),
            _renderItem(),
            _renderItem(),
            _renderItem(),
            _renderItem(),
            _renderItem(),
          ],
        ),
      ),
    );
  }

  Container _renderItem() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          // Container(
          //   width: 80,
          //   height: 80,
          //   decoration: BoxDecoration(
          //     color: Colors.black,
          //     borderRadius: BorderRadius.circular(100),
          //   ),
          // ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 100,
                        margin: EdgeInsets.all(5),
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: 100,
                        margin: EdgeInsets.all(5),
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  // width: 100,
                  margin: EdgeInsets.all(5),
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                // Container(
                //   // width: 100,
                //   margin: EdgeInsets.all(5),
                //   height: 15,
                //   decoration: BoxDecoration(
                //     color: Colors.black,
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
