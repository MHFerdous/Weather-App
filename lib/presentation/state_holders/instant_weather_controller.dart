import 'dart:async';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:weather_app_flutter/data/models/instant_weather_list_model.dart';
import 'package:weather_app_flutter/data/models/network_response.dart';
import 'package:weather_app_flutter/data/models/hourly_weather_list_model.dart';
import 'package:weather_app_flutter/data/services/network_caller.dart';
import 'package:weather_app_flutter/data/utility/urls.dart';

class InstantWeatherController extends GetxController {
  bool _getInstantWeatherInProgress = false;
  final HourlyWeatherListModel _hourlyWeatherListModel =
      HourlyWeatherListModel();
  InstantWeatherListModel _instantWeatherListModel = InstantWeatherListModel();

  bool get getInstantWeatherInProgress => _getInstantWeatherInProgress;
  HourlyWeatherListModel? get hourlyWeatherListModel => _hourlyWeatherListModel;
  InstantWeatherListModel? get instantWeatherListModel =>
      _instantWeatherListModel;

  Future<bool> getInstantWeather() async {
    _getInstantWeatherInProgress = true;
    update();
    /*final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.getInstantWeather(LocationController().locationData!.latitude!,
          LocationController().locationData!.longitude!),
    );*/
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.getInstantWeather(37.4219983,
          -122.084),
    );
    _getInstantWeatherInProgress = false;
    if (response.isSuccess) {
      _instantWeatherListModel =
          InstantWeatherListModel.fromJson(response.responseJson!);

      update();
      return true;
    } else {
      return false;
    }
  }
}
