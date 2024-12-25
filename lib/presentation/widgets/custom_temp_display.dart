import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app_flutter/presentation/utility/image_icon_assets.dart';

class CustomTempDisplay extends StatelessWidget {
  const CustomTempDisplay({
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
          width: 135,
          height: 130,
        ),
        Text(
          '13',
          style: TextStyle(
            fontSize: 122,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
