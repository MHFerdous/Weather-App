import 'dart:async';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:location/location.dart';
import 'package:weather_app_flutter/data/models/instant_weather_list_model.dart';
import 'package:weather_app_flutter/data/models/network_response.dart';
import 'package:weather_app_flutter/data/models/hourly_weather_list_model.dart';
import 'package:weather_app_flutter/data/services/network_caller.dart';
import 'package:weather_app_flutter/data/utility/urls.dart';
import 'package:weather_app_flutter/presentation/state_holders/location_controller.dart';

class HourlyForecastController extends GetxController {
  bool _getHourlyForecastInProgress = false;
  HourlyWeatherListModel _hourlyWeatherListModel = HourlyWeatherListModel();
  final InstantWeatherListModel _instantWeatherListModel =
      InstantWeatherListModel();
  LocationData? _myCurrentLocation;
  StreamSubscription? _locationSubscription;

  bool get getHourlyForecastInProgress => _getHourlyForecastInProgress;
  HourlyWeatherListModel? get hourlyWeatherListModel => _hourlyWeatherListModel;
  InstantWeatherListModel? get instantWeatherListModel =>
      _instantWeatherListModel;
  LocationData? get locationData => _myCurrentLocation;
  StreamSubscription? get streamSubscription => _locationSubscription;

  Future<bool> getHourlyWeather() async {
    _getHourlyForecastInProgress = true;
    update();
    /*final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.getHourlyWeather(LocationController().locationData!.latitude!,
          LocationController().locationData!.longitude!),
    );*/
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.getHourlyWeather(37.4219983,
      -122.084),
    );
    _getHourlyForecastInProgress = false;
    if (response.isSuccess) {
      _hourlyWeatherListModel =
          HourlyWeatherListModel.fromJson(response.responseJson!);

      update();
      return true;
    } else {
      return false;
    }
  }
}
