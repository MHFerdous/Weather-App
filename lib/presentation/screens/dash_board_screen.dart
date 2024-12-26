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
                height: 50,
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
                height: 16,
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
                            ? Colors.blue.shade400
                            : Colors.blue.shade600,
                      ),
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
                            : Colors.blue.shade500,
                      ),
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
                height: 16,
              ),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // itemCount: 5,
                  itemCount: locationController
                          .hourlyWeatherListModel?.weatherData?.length ??
                      5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 158,
                        width: 72,
                        child: Card(
                          color: Colors.blue.shade300,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat('hh a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      locationController.hourlyWeatherListModel!
                                              .weatherData![index].dt! *
                                          1000,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${locationController.hourlyWeatherListModel!.weatherData![index].main!.temp!.toString()}°C',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 16,
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
