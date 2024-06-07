import 'package:geolocator/geolocator.dart';
import 'dart:math';

class MyLocation {
  late double currentLatitude;
  late double currentLongitude;

  Future<void> getCurrentLocation() async {
    try {
      // 위치 권한 요청
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // 위치 권한이 거부된 경우에 대한 처리
        print('위치 권한이 거부되었습니다.');
        return;
      }

      // 위치 가져오기
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLatitude = position.latitude;
      currentLongitude = position.longitude;
      print('위도 !!!!!!!!!!!!!!!!!!!!: ${currentLatitude}');
      print('경도 !!!!!!!!!!!!!!!!!!!!: ${currentLongitude}');
    } catch (e) {
      // 위치 가져오기에 실패한 경우에 대한 처리
      print('현재 위치를 가져오는 데 실패했습니다: $e');
    }
  }
}

class WeatherMapXY {
  int x;
  int y;
  WeatherMapXY(this.x, this.y);
}

class LamcParameter {
  late double Re; /* 사용할 지구반경 [ km ]      */
  late double grid; /* 격자간격        [ km ]      */
  late double slat1; /* 표준위도        [degree]    */
  late double slat2; /* 표준위도        [degree]    */
  late double olon; /* 기준점의 경도   [degree]    */
  late double olat; /* 기준점의 위도   [degree]    */
  late double xo; /* 기준점의 X 좌표  [격자거리]  */
  late double yo; /* 기준점의 Y 좌표  [격자거리]  */
  late int first; /* 시작여부 (0 = 시작)         */
}

WeatherMapXY changelaluMap(double longitude, double latitude) {
  int NX = 149; /* X 축 격자점 수 */
  int NY = 253; /* Y 축 격자점 수 */
  const double PI = 3.1415926535897931;
  const double DEGRAD = PI / 180.0;
  const double RADDEG = 180.0 / PI;

  double re = 6371.00877; // 지도반경
  double grid = 5.0; // 격자간격 (km)
  double slat1 = 30.0 * DEGRAD; // 표준위도 1
  double slat2 = 60.0 * DEGRAD; // 표준위도 2
  double olon = 126.0 * DEGRAD; // 기준점 경도
  double olat = 38.0 * DEGRAD; // 기준점 위도
  double xo = 210 / grid; // 기준점 X 좌표
  double yo = 675 / grid; // 기준점 Y 좌표

  double sn = tan(PI * 0.25 + slat2 * 0.5) / tan(PI * 0.25 + slat1 * 0.5);
  sn = log(cos(slat1) / cos(slat2)) / log(sn);
  double sf = tan(PI * 0.25 + slat1 * 0.5);
  sf = pow(sf, sn) * cos(slat1) / sn;
  double ro = tan(PI * 0.25 + olat * 0.5);
  ro = re * sf / pow(ro, sn);

  double ra = tan(PI * 0.25 + latitude * DEGRAD * 0.5);
  ra = re * sf / pow(ra, sn);
  double theta = longitude * DEGRAD - olon;
  if (theta > PI) theta -= 2.0 * PI;
  if (theta < -PI) theta += 2.0 * PI;
  theta *= sn;

  double x = (ra * sin(theta)) + xo;
  double y = (ro - ra * cos(theta)) + yo;
  x = x + 1.5;
  y = y + 1.5;
  return WeatherMapXY(x.toInt(), y.toInt());
}