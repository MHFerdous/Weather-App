import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weather_app_flutter/presentation/screens/dash_board_screen.dart';
import 'package:weather_app_flutter/presentation/state_holders/location_controller.dart';
import 'package:weather_app_flutter/presentation/utility/app_colors.dart';
import 'package:weather_app_flutter/presentation/utility/image_icon_assets.dart';
import 'package:weather_app_flutter/presentation/widgets/responsive_builder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LocationController>().getMyLocation();
    });
    Timer(
      Duration(seconds: 6),
      () => Get.to(
        () => DashBoardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightThemeData.primaryColor,
      body: ResponsiveBuilder(
        phone: _buildPhoneLayout(),
        smallPhone: _buildSmallPhoneLayout(),
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          const Spacer(),
          SvgPicture.asset(
            ImageAndIconAssets.appIconSVG,
            width: 100,
          ),
          const Spacer(),
          const CircularProgressIndicator(),
          const Text('Version 1.0.0'),
        ],
      ),
    );
  }

  Widget _buildSmallPhoneLayout() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          const Spacer(),
          SvgPicture.asset(
            ImageAndIconAssets.appIconSVG,
            width: 100,
          ),
          const Spacer(),
          const CircularProgressIndicator(),
          const Text('Version 1.0.0'),
        ],
      ),
    );
  }
}
