import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MyLocation {
  late double currentLatitude;
  late double currentLongitude;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentLatitude = position.latitude;
      currentLongitude = position.longitude;
      print(currentLatitude);
      print(currentLongitude);
    } catch(e){
      print('There was a problem with the internet connection.');
    }


    // 위치권한을 가지고 있는지 확인
    // var status_position = await Permission.location.status;
    //
    // if (status_position.isGranted) {
    //   // 1-2. 권한이 있는 경우 위치정보를 받아와서 변수에 저장합니다.
    //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //
    //   currentLatitude = position.latitude;
    //   currentLongitude = position.longitude;
    //
    // } else {
    //   // 1-3. 권한이 없는 경우
    //   print("위치 권한이 필요합니다.");
    // }
  } // ...getMyCurrentLocation()

}