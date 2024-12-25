import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app_flutter/presentation/utility/app_colors.dart';
import 'package:weather_app_flutter/presentation/utility/image_icon_assets.dart';
import 'package:weather_app_flutter/presentation/widgets/custom_description_display.dart';
import 'package:weather_app_flutter/presentation/widgets/custom_details_section.dart';
import 'package:weather_app_flutter/presentation/widgets/custom_location_display.dart';
import 'package:weather_app_flutter/presentation/widgets/custom_temp_display.dart';
import 'package:weather_app_flutter/presentation/widgets/responsive_builder.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool _isButton1Active = true;
  bool _isButton2Active = false;
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
        children: [
          Text('data'),
        ],
      ),
    );
  }

  Widget _buildSmallPhoneLayout() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          SizedBox(
            height: 56,
          ),
          CustomLocationDisplay(),
          CustomTempDisplay(),
          CustomDescriptionDisplay(),
          SizedBox(
            height: 25,
          ),

          SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              SizedBox(
                width: 108,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _isButton1Active
                          ? Colors.lightBlue
                          : Colors.blueAccent),
                  onPressed: () {
                    _isButton1Active = true;
                    _isButton2Active = false;
                    setState(() {});
                  },
                  child: Text('Today'),
                ),
              ),
              SizedBox(
                width: 134,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _isButton2Active
                          ? Colors.lightBlue
                          : Colors.blueAccent),
                  onPressed: () {
                    _isButton2Active = true;
                    _isButton1Active = false;
                    setState(() {});
                  },
                  child: Text('Next Days'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          CustomDetailsSection(),
        ],
      ),
    );
  }
}
