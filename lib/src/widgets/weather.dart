import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/components/image_data.dart';

import '../data/my_location.dart';
import '../data/network.dart';
import 'location.dart';

class Weather extends StatefulWidget {
  const Weather({
    super.key,
    required this.isSmall,
    required this.isEditable,
    this.maxTemperature,
    this.minTemperature,
    this.precipitationType,
    this.skyState,
    this.location,
  });

  final bool isSmall;
  final bool isEditable;
  final double? maxTemperature;
  final double? minTemperature;
  final int? precipitationType;
  final int? skyState;
  final String? location;

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String location = "전주시";

  @override
  Widget build(BuildContext context) {
    if (widget.location != null) {
      location = widget.location!;
    }
    if (!widget.isSmall) {
      return Stack(
        children: [
          Container(
            width: 345,
            height: 90,
            decoration: ShapeDecoration(
                color: const Color(0xffFFF5F6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          ),
          // TODO: 날씨 아이콘
          Positioned(
            left: 20,
            top: 20,
            child: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset(IconPath.mococoLogo),
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
                    location,
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
                    text: '${widget.maxTemperature?.toInt() ?? ''}℃',
                    style: TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: ' / ',
                    style: TextStyle(color: Color(0xff494949), fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: '${widget.minTemperature?.toInt() ?? ''}℃',
                    style: TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          // TODO: 날씨 아이콘
          SizedBox(
            width: 24,
            height: 24,
            child: Image.asset(IconPath.mococoLogo),
          ),
          const SizedBox(width: 6),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '24℃',
                  style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: ' / ',
                  style: TextStyle(color: Color(0xff494949), fontSize: 16, fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: '11℃',
                  style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w600),
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
                    location,
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
              location,
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
              });
            }
          ),
        );
      },
    );
  }
}
