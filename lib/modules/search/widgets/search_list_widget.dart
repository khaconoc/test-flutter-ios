import 'package:bccp_mobile_v2/modules/search/search_controller.dart';
import 'package:bccp_mobile_v2/routes/pages.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class SearchListWidget extends StatelessWidget {
  final SearchController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: controller.listOfData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.DELIVERY_DETAIL, );
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
                            Image.network(
                              'https://hips.hearstapps.com/pop.h-cdn.co/assets/cm/15/05/54cab87277420_-_roughpackage-300-md.jpg',
                              height: 100,
                              width: 100,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        // Text('Khách hàng:'),
                                        Icon(LineIcons.gift),
                                        Text('Bộ ấm chén bằng sứ cao cấp'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        // Text('Khách hàng:'),
                                        Icon(LineIcons.user),
                                        Text('Dương Quá'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        // Text('Địa chỉ:'),
                                        Icon(LineIcons.map_marker),
                                        Text('Số 6 ngõ 18 Nguyên Hồng'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(LineIcons.phone),
                                        Text('0987654321'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Text('1.5 Kg'),
                          ],
                        ),
                        SizedBox(
                          child: Divider(),
                          width: 250,
                        )
                      ],
                    ),
                    // height: 100,
                  ),
                  Positioned(
                    child: Image.asset(
                      'assets/images/dacbiet.png',
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
