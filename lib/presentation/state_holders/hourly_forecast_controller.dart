/*
import 'dart:async';
import 'dart:developer';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:location/location.dart';
import 'package:weather_app_flutter/data/models/instant_weather_list_model.dart';
import 'package:weather_app_flutter/data/models/network_response.dart';
import 'package:weather_app_flutter/data/models/hourly_weather_list_model.dart';
import 'package:weather_app_flutter/data/services/network_caller.dart';
import 'package:weather_app_flutter/data/utility/urls.dart';

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

  Future<bool> getHourlyWeather(double latitude, double longitude) async {
    _getHourlyForecastInProgress = true;
    update();

    try {
      final NetworkResponse response = await NetworkCaller.getRequest(
        Urls.getHourlyWeather(latitude, longitude),
      );

      if (response.isSuccess && response.responseJson != null) {
        _hourlyWeatherListModel =
            HourlyWeatherListModel.fromJson(response.responseJson!);
        update();
        return true;
      } else {
        log('Failed to fetch hourly weather');
        return false;
      }
    } catch (e) {
      //  _getHourlyForecastInProgress = false;
      log('Error fetching hourly weather: $e');
      return false;
    } finally {
      _getHourlyForecastInProgress = false;
      update();
    }
  }

  @override
  void onClose() {
    _locationSubscription?.cancel();
    super.onClose();
  }
}
*/
