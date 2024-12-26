import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_flutter/presentation/state_holders/location_controller.dart';
import 'package:weather_app_flutter/presentation/utility/app_colors.dart';
import 'package:weather_app_flutter/presentation/utility/image_icon_assets.dart';
import 'package:weather_app_flutter/presentation/widgets/custom_description_display.dart';
import 'package:weather_app_flutter/presentation/widgets/custom_details_card.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LocationController>().getMyLocation();
    });
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
        children: [
          Text('data'),
        ],
      ),
    );
  }

  Widget _buildSmallPhoneLayout() {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        if (locationController.getCartListInProgress ||
            locationController.locationData == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              SizedBox(
                height: 56,
              ),
              CustomLocationDisplay(
                  location: locationController.instantWeatherListModel?.name
                          .toString() ??
                      'Loading'),
              CustomTempDisplay(
                  temperature:
                      '${locationController.instantWeatherListModel!.main?.temp} °C'),
              CustomDescriptionDisplay(
                description: locationController
                        .instantWeatherListModel!.weather?[0].description
                        .toString() ??
                    'loading',
              ),
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
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomDetailsCard(
                          title: 'Sunrise',
                          subTitle: DateFormat('hh:mm a').format(
                            DateTime.fromMillisecondsSinceEpoch(
                              locationController
                                      .instantWeatherListModel!.sys!.sunrise! *
                                  1000,
                            ),
                          ),
                          leadingIcon: SvgPicture.asset(
                            ImageAndIconAssets.locationIconSVG,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        CustomDetailsCard(
                          title: 'Sunset',
                          subTitle: DateFormat('hh:mm a').format(
                            DateTime.fromMillisecondsSinceEpoch(
                              locationController
                                      .instantWeatherListModel!.sys!.sunrise! *
                                  1000,
                            ),
                          ),
                          leadingIcon: SvgPicture.asset(
                            ImageAndIconAssets.locationIconSVG,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        CustomDetailsCard(
                          title: 'Wind Speed',
                          subTitle:
                              '${locationController.instantWeatherListModel?.wind?.speed} m/s',
                          leadingIcon: SvgPicture.asset(
                            ImageAndIconAssets.locationIconSVG,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        CustomDetailsCard(
                          title: 'Humidity',
                          subTitle:
                              '${locationController.instantWeatherListModel?.main?.humidity} %',
                          leadingIcon: SvgPicture.asset(
                            ImageAndIconAssets.locationIconSVG,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        CustomDetailsCard(
                          title: 'Pressure',
                          subTitle:
                              '${locationController.instantWeatherListModel?.main?.pressure} hPa',
                          leadingIcon: SvgPicture.asset(
                            ImageAndIconAssets.locationIconSVG,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        CustomDetailsCard(
                          title: 'Visibility',
                          subTitle:
                              '${locationController.instantWeatherListModel?.visibility} m',
                          leadingIcon: SvgPicture.asset(
                            ImageAndIconAssets.locationIconSVG,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
