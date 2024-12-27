import 'package:flutter/material.dart';
import 'package:weather_app_flutter/data/utility/urls.dart';

class CustomTempDisplay extends StatefulWidget {
  const CustomTempDisplay({
    super.key,
    required this.temperature,
    required this.iconId,
  });
  final String temperature;
  final String iconId;

  @override
  State<CustomTempDisplay> createState() => _CustomTempDisplayState();
}

class _CustomTempDisplayState extends State<CustomTempDisplay> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Image.network(
          Urls.getWeatherIcon(widget.iconId),
          height: 100,
          width: 100,
        ),
        Text(
          widget.temperature,
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
