import 'package:badges/badges.dart';
import 'package:bccp_mobile_v2/core/utils/helpers.dart';
import 'package:bccp_mobile_v2/theme/app_theme.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppListViewLoadMore extends StatefulWidget {
  final Function onLoadMore;
  final Function onPress;
  final bool isEmpty;
  final bool isLoading;
  final List listValue;

  AppListViewLoadMore({
    this.onLoadMore,
    this.onPress,
    this.isEmpty = false,
    this.isLoading = false,
    this.listValue = const [],
  });

  @override
  _AppListViewLoadMoreState createState() => _AppListViewLoadMoreState();
}

class _AppListViewLoadMoreState extends State<AppListViewLoadMore> {
  Widget _renderItem(int index, Map data) {
    String imageUrl = Helpers.getFirstImageString(data['attachFile']);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(20),
          color: mainColor.withAlpha(30),
          border: Border(
              left: BorderSide(
            color: Colors.redAccent,
            width: 5,
          ))),
      child: Row(
        children: [
          // Checkbox(value: false, onChanged: (value) {}),
          Expanded(
            child: InkWell(
              onTap: () async {
                widget.onPress(
                    data['requestID'], data['itemID'], data['requestDetailID']);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              imageUrl.isNotEmpty
                                  ? ClipRRect(
                                      child: FadeInImage.assetNetwork(
                                        image: imageUrl,
                                        height: 70,
                                        width: 70,
                                        placeholder:
                                            'assets/images/image_loading.gif',
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                  : ClipRRect(
                                      child: Image.asset(
                                        'assets/images/no-image.png',
                                        height: 70,
                                        width: 70,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data['itemCode'] ?? ''),
                                      Text(data['receiverFullName'] ?? ''),
                                      Text(data['receiverAddress'] ?? ''),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // height: 100,
                    ),
                    Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                              child: Text(
                            '${index + 1}',
                            style: BccpAppTheme.textStyleWhite,
                          )),
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ...List.generate(widget.listValue.length,
              (index) => _renderItem(index, widget.listValue[index])),
          IfWidget(
            condition: !widget.isEmpty,
            right: IfWidget(
              condition: !widget.isLoading,
              right: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Hiển thị thêm',
                    style: TextStyle(color: mainColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        widget.onLoadMore();
                      },
                  ),
                ),
              ),
              wrong: SpinKitFadingCircle(color: Colors.grey, size: 15,),
            ),
          ),
        ],
      ),
    );
  }
}
