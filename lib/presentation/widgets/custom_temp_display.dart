import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_flutter/presentation/utility/image_icon_assets.dart';

class CustomTempDisplay extends StatefulWidget {
  const CustomTempDisplay({
    super.key,
    required this.temperature,
  });
  final String temperature;

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
        SvgPicture.asset(
          ImageAndIconAssets.locationIconSVG,
          width: 135,
          height: 130,
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
