import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PositionService extends GetxService {

  Future<PositionService> init() async {
    return this;
  }

  Future<bool> getPermissionPosition() async {
    var status = await Permission.location.status;
    return status.isGranted;
  }

  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.

    try{
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      print(e);
    }

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // Thiết bị tắt vị trí
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // thiết bị bật vị trí nhưng không cho phép app dùng vị trí
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // nếu app tắt vị trí mãi mãi đối với app
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<PositionStatus> getPositionStatus() async {
    bool serviceEnabled;
    LocationPermission permission;

    try{
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return PositionStatus.off;
      }
    } catch (e) {
      return PositionStatus.off;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // thiết bị bật vị trí nhưng không cho phép app dùng vị trí
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return PositionStatus.denied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // nếu app tắt vị trí mãi mãi đối với app
      return PositionStatus.deniedForever;
    }

    return PositionStatus.active;
  }

}

enum PositionStatus {
  active, /// hoạt động
  off, /// vị trí đang tắt
  denied, /// từ chối quyền
  deniedForever /// từ chối quyền mãi mãi
}