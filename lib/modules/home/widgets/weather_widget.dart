import 'package:app_settings/app_settings.dart';
import 'package:bccp_mobile_v2/modules/home/home_controller.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class WeatherWidget extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 200,
        padding: EdgeInsets.all(10),
        child: IfWidget(
            condition: controller.loadingWeather.value,
            right: Shimmer.fromColors(
              baseColor: Colors.blue[300],
              highlightColor: Colors.blue[100],
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            wrong: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  image: AssetImage(controller.texture.value,),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: IfWidget(
                  condition: controller.permissionLocation.value,
                  right: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                controller.myLocationText ?? '',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                '${controller.myTempText ?? ''} °C',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  controller.weekDay.value ?? '',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  controller.dateNow.value ?? '',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Text(
                      //   'Thứ 3, 11/05/2021',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 15,
                      //   ),
                      // ),
                      Text(
                        controller.message.value ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  wrong: InkWell(
                    onTap: AppSettings.openAppSettings,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Không thể truy cập vị trí',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Mở cài đặt',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
