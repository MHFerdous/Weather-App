import 'package:flutter/material.dart';
import 'package:weather_app_flutter/presentation/utility/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: AppColors.lightThemeData.primaryColor,
    );
  }
}
