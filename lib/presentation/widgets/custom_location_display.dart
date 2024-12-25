import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_flutter/presentation/utility/image_icon_assets.dart';

class CustomLocationDisplay extends StatelessWidget {
  const CustomLocationDisplay({
    super.key,
  });

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
          'Sylhet',
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
