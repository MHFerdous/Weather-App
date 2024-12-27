import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_flutter/data/utility/urls.dart';
import 'package:weather_app_flutter/presentation/state_holders/location_controller.dart';
import 'package:weather_app_flutter/presentation/utility/app_colors.dart';
import 'package:weather_app_flutter/presentation/utility/image_icon_assets.dart';
import 'package:weather_app_flutter/presentation/widgets/custom_buttons.dart';
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
  final ValueNotifier<bool> _isButton1ActiveNotifier =
      ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isButton2ActiveNotifier =
      ValueNotifier<bool>(false);

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
      body: SafeArea(
        child: ResponsiveBuilder(
          phone: _buildPhoneLayout(),
          smallPhone: _buildSmallPhoneLayout(),
        ),
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        if (locationController.locationInProgress ||
            locationController.getInstantWeatherInProgress ||
            locationController.getHourlyForecastInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        log(locationController.getInstantWeatherInProgress.toString());
        log('code: ${locationController.instantWeatherListModel!.cod.toString()}');
        log('name: ${locationController.instantWeatherListModel!.name.toString()}');

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              SizedBox(
                height: 4,
              ),
              CustomLocationDisplay(
                  location: locationController.instantWeatherListModel?.name
                          .toString() ??
                      'Loading'),
              CustomTempDisplay(
                iconId: locationController
                    .instantWeatherListModel!.weather![0].icon!,
                temperature: double.parse(locationController
                    .instantWeatherListModel!.main!.temp!
                    .toStringAsFixed(1)),
              ),
              CustomDescriptionDisplay(
                description: locationController
                        .instantWeatherListModel!.weather?[0].description
                        .toString() ??
                    'loading',
              ),
              SizedBox(
                height: 16,
              ),
              CustomButtons(
                  isButton1ActiveNotifier: _isButton1ActiveNotifier,
                  isButton2ActiveNotifier: _isButton2ActiveNotifier),
              SizedBox(
                height: 8,
              ),
              customTodayAndUpcomingTemp(locationController,
                  _isButton1ActiveNotifier, _isButton2ActiveNotifier),
              SizedBox(
                height: 8,
              ),
              customWeatherDetails(locationController),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSmallPhoneLayout() {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        if (locationController.locationInProgress ||
            locationController.getInstantWeatherInProgress ||
            locationController.getHourlyForecastInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        log(locationController.getInstantWeatherInProgress.toString());
        log('code: ${locationController.instantWeatherListModel!.cod.toString()}');
        log('name: ${locationController.instantWeatherListModel!.name.toString()}');

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              SizedBox(
                height: 4,
              ),
              CustomLocationDisplay(
                  location: locationController.instantWeatherListModel?.name
                          .toString() ??
                      'Loading'),
              CustomTempDisplay(
                iconId: locationController
                    .instantWeatherListModel!.weather![0].icon!,
                temperature: double.parse(locationController
                    .instantWeatherListModel!.main!.temp!
                    .toStringAsFixed(1)),
              ),
              CustomDescriptionDisplay(
                description: locationController
                        .instantWeatherListModel!.weather?[0].description
                        .toString() ??
                    'loading',
              ),
              SizedBox(
                height: 16,
              ),
              CustomButtons(
                  isButton1ActiveNotifier: _isButton1ActiveNotifier,
                  isButton2ActiveNotifier: _isButton2ActiveNotifier),
              SizedBox(
                height: 8,
              ),
              customTodayAndUpcomingTemp(locationController,
                  _isButton1ActiveNotifier, _isButton2ActiveNotifier),
              SizedBox(
                height: 8,
              ),
              customWeatherDetails(locationController),
            ],
          ),
        );
      },
    );
  }

  Widget customTodayAndUpcomingTemp(
      LocationController locationController,
      ValueNotifier<bool> isButton1ActiveNotifier,
      final ValueNotifier<bool> isButton2ActiveNotifier) {
    return SizedBox(
      height: 148,
      child: ValueListenableBuilder<bool>(
        valueListenable: isButton1ActiveNotifier,
        builder: (context, isButton1Active, child) {
          if (isButton1Active) {
            return (locationController.hourlyWeatherListModel
                        ?.getTodaysWeatherData()
                        .isNotEmpty ??
                    false)
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: locationController.hourlyWeatherListModel
                            ?.getTodaysWeatherData()
                            .length ??
                        5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          color: Colors.blue.shade300,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat('dd-MMM\nhh a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      locationController.hourlyWeatherListModel!
                                              .getTodaysWeatherData()[index]
                                              .dt! *
                                          1000,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Image.network(
                                  Urls.getWeatherIcon(
                                    locationController.hourlyWeatherListModel!
                                        .weatherData![index].weather![0].icon
                                        .toString(),
                                  ),
                                  height: 60,
                                  width: 60,
                                ),
                                Spacer(),
                                Text(
                                  '${locationController.hourlyWeatherListModel!.weatherData![index].main!.temp!.toStringAsFixed(1)}°C',
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'Nothing to show',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  );
          } else {
            return (locationController.hourlyWeatherListModel
                        ?.getFutureWeatherData()
                        .isNotEmpty ??
                    false)
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: locationController.hourlyWeatherListModel
                            ?.getFutureWeatherData()
                            .length ??
                        5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          color: Colors.blue.shade300,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat('dd-MMM\nhh a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      locationController.hourlyWeatherListModel!
                                              .getFutureWeatherData()[index]
                                              .dt! *
                                          1000,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Image.network(
                                  Urls.getWeatherIcon(
                                    locationController.hourlyWeatherListModel!
                                        .weatherData![index].weather![0].icon
                                        .toString(),
                                  ),
                                  height: 60,
                                  width: 60,
                                ),
                                Spacer(),
                                Text(
                                  '${locationController.hourlyWeatherListModel!.weatherData![index + 1].main!.temp!.toStringAsFixed(1)}°C',
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'Nothing to show',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  );
          }
        },
      ),
    );
  }

  Widget customWeatherDetails(LocationController locationController) {
    return Expanded(
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
                    locationController.instantWeatherListModel!.sys!.sunrise! *
                        1000,
                  ),
                ),
                leadingIcon: SvgPicture.asset(
                  ImageAndIconAssets.locationIconSVG,
                  height: 45,
                  width: 45,
                ),
              ),
              CustomDetailsCard(
                title: 'Sunset',
                subTitle: DateFormat('hh:mm a').format(
                  DateTime.fromMillisecondsSinceEpoch(
                    locationController.instantWeatherListModel!.sys!.sunrise! *
                        1000,
                  ),
                ),
                leadingIcon: SvgPicture.asset(
                  ImageAndIconAssets.locationIconSVG,
                  height: 45,
                  width: 45,
                ),
              ),
              CustomDetailsCard(
                title: 'Wind Speed',
                subTitle:
                    '${locationController.instantWeatherListModel?.wind?.speed} m/s',
                leadingIcon: SvgPicture.asset(
                  ImageAndIconAssets.locationIconSVG,
                  height: 45,
                  width: 45,
                ),
              ),
              CustomDetailsCard(
                title: 'Humidity',
                subTitle:
                    '${locationController.instantWeatherListModel?.main?.humidity} %',
                leadingIcon: SvgPicture.asset(
                  ImageAndIconAssets.locationIconSVG,
                  height: 45,
                  width: 45,
                ),
              ),
              CustomDetailsCard(
                title: 'Pressure',
                subTitle:
                    '${locationController.instantWeatherListModel?.main?.pressure} hPa',
                leadingIcon: SvgPicture.asset(
                  ImageAndIconAssets.locationIconSVG,
                  height: 45,
                  width: 45,
                ),
              ),
              CustomDetailsCard(
                title: 'Visibility',
                subTitle:
                    '${locationController.instantWeatherListModel?.visibility} m',
                leadingIcon: SvgPicture.asset(
                  ImageAndIconAssets.locationIconSVG,
                  height: 45,
                  width: 45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isButton1ActiveNotifier.dispose();
    _isButton2ActiveNotifier.dispose();
    super.dispose();
  }
}
