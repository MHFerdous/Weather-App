import 'package:flutter/material.dart';
import 'package:weather_app_flutter/presentation/utility/screen_utils.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.phone,
    required this.smallPhone,
  });

  final Widget smallPhone;
  final Widget phone;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final DeviceType deviceType = ScreenUtils.getDeviceType(size.width);

    if (deviceType == DeviceType.smallPhone) {
      return smallPhone;
    }
    return phone;
  }
}
