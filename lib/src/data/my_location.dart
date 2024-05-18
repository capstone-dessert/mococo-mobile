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
  } // ...getMyCurrentLocation()
}