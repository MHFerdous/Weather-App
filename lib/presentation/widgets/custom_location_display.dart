import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_flutter/presentation/utility/image_icon_assets.dart';

class CustomLocationDisplay extends StatefulWidget {
  const CustomLocationDisplay({
    super.key,
    required this.location,
  });
  final String location;

  @override
  State<CustomLocationDisplay> createState() => _CustomLocationDisplayState();
}

class _CustomLocationDisplayState extends State<CustomLocationDisplay> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        SvgPicture.asset(
          ImageAndIconAssets.locationIconSVG,
          height: 30,
          width: 30,
        ),
        Text(
          widget.location,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
