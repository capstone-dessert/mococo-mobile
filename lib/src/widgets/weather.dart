import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/image_data.dart';
import 'package:mococo_mobile/src/models/weather.dart';
import 'package:mococo_mobile/src/service/http_service.dart';

import '../data/my_location.dart';
import 'location.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({
    super.key,
    required this.isSmall,
    required this.isEditable,
    this.date,
    this.weather,
    this.getDate,
    this.setSelectedLocation,
    this.setWeather
  });

  final bool isSmall;
  final bool isEditable;
  final DateTime? date;
  final Weather? weather;

  final Function? getDate;
  final Function? setSelectedLocation;
  final Function? setWeather;

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {

  bool isLoading = true;
  late DateTime date;
  late Weather weather;
  late MyLocation myLocation;
  String? location;

  @override
  void initState() {
    super.initState();
    if (widget.weather == null) {
      date = widget.getDate!();
      myLocation = MyLocation();
      myLocation.updateCurrentLocation().then((_) {
        var latitude = myLocation.getLatitude();
        var longitude = myLocation.getLongitude();
        getWeatherByGeo(date, latitude, longitude).then((value) {
          setState(() {
            weather = value;
            if (widget.setWeather != null) {
              widget.setWeather!(weather);
            }
            isLoading = false;
          });
        });
      });
    } else {
      weather = widget.weather!;
      if (widget.getDate != null) {
        date = widget.getDate!();
      }
      isLoading = false;
    }
  }

  @override
  void didUpdateWidget(covariant WeatherWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.getDate != null) {
      DateTime newDate = widget.getDate!();
      if (date.year != newDate.year || date.month != newDate.month || date.day != newDate.day) {
        date = newDate;
        isLoading = true;
        if (location != null) {
          var latitude = myLocation.getLatitude();
          var longitude = myLocation.getLongitude();
          getWeatherByGeo(date, latitude, longitude).then((value) {
            setState(() {
              weather = value;
              widget.setWeather!(weather);
              isLoading = false;
            });
          });
        } else {
          getWeatherByAddress(date, location!).then((value) {
            setState(() {
              weather = value;
              widget.setWeather!(weather);
              isLoading = false;
            });
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isSmall) {
      if (isLoading) {
        return Container(
          width: MediaQuery.of(context).size.width - 48,
          height: 90,
          decoration: ShapeDecoration(
            color: const Color(0xffFFF5F6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
          ),
          child: const Column(
            children: [
              Spacer(),
              CircularProgressIndicator(color: Colors.black12),
              Spacer()
            ],
          ),
        );
      } else {
        return Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 48,
              height: 90,
              decoration: ShapeDecoration(
                color: const Color(0xffFFF5F6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
              ),
            ),
            Positioned(
              left: 20,
              top: 20,
              child: SizedBox(
                width: 50,
                height: 50,
                child: isLoading ?  const SizedBox.shrink(): Image.asset(IconPath.weather[weather.sky][weather.precipitationType]),
              ),
            ),
            Positioned(
              left: 90,
              top: 18,
              child: TextButton(
                onPressed: () {
                  _showModalBottomSheet();
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  children: [
                    Text(
                      weather.location,
                      style: const TextStyle(fontSize: 18, color: Colors.black, decoration: TextDecoration.underline, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 3),
                    SizedBox(
                      width: 22,
                      child: Image.asset(IconPath.editCondition),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 90,
              top: 50,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${weather.maxTemperature}℃',
                      style: const TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    const TextSpan(
                      text: ' / ',
                      style: TextStyle(color: Color(0xff494949), fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: '${weather.minTemperature}℃',
                      style: const TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    } else {
      return Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: isLoading ?  const SizedBox.shrink(): Image.asset(IconPath.weather[weather.sky][weather.precipitationType]),
          ),
          const SizedBox(width: 8),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: isLoading ? '––℃' : '${weather.minTemperature}℃',
                  style: const TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const TextSpan(
                  text: ' / ',
                  style: TextStyle(color: Color(0xff494949), fontSize: 16, fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: isLoading ? '––℃' : '${weather.maxTemperature}℃',
                  style: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 7),
          if (widget.isEditable)
            TextButton(
              onPressed: () {
                _showModalBottomSheet();
              },
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                children: [
                  Text(
                    isLoading
                      ? '–––'
                      : (weather.location.split(' ').length == 2)
                        ? weather.location.split(' ')[1]
                        : weather.location,
                    style: const TextStyle(fontSize: 16, color: Color(0xff494949), decoration: TextDecoration.underline, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 22,
                    child: Image.asset(IconPath.editCondition),
                  )
                ],
              ),
            )
          else
            Text(
              (weather.location.split(' ').length == 2)
                ? weather.location.split(' ')[1]
                : weather.location,
              style: const TextStyle(fontSize: 16, color: Color(0xff494949), fontWeight: FontWeight.w600),
            ),
          const SizedBox(width: 4),
        ],
      );
    }
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      elevation: 0,
      useRootNavigator: widget.isSmall ? true : false,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: widget.isSmall ? MediaQuery.of(context).size.height - 120 - 32 - 25 : 680,
          child: LocationSelector(
            onLocationSelected: (newLocation) {
              setState(() {
                location = newLocation;
                isLoading = true;
                getWeatherByAddress(date, location!).then((value) {
                  setState(() {
                    weather = value;
                    widget.setWeather!(weather);
                    isLoading = false;
                  });
                });
              });
            }
          ),
        );
      },
    );
  }
}
