import 'package:geolocator/geolocator.dart';
import 'dart:developer';


class MyLocation {

  late double currentLatitude;
  late double currentLongitude;

  Future<void> updateCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('위치 권한이 거부되었습니다.');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLatitude = position.latitude;
      currentLongitude = position.longitude;
      log('위경도: {$currentLatitude, $currentLatitude}');
    } catch (e) {
      throw Exception ('현재 위치를 가져오는 데 실패했습니다: $e');
    }
  }

  double getLatitude() {
    return currentLatitude;
  }

  double getLongitude() {
    return currentLongitude;
  }
}