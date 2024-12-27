import 'dart:async';
import 'dart:developer';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:weather_app_flutter/data/models/instant_weather_list_model.dart';
import 'package:weather_app_flutter/data/models/network_response.dart';
import 'package:weather_app_flutter/data/services/network_caller.dart';
import 'package:weather_app_flutter/data/utility/urls.dart';

class InstantWeatherController extends GetxController {
  bool _getInstantWeatherInProgress = false;
  InstantWeatherListModel _instantWeatherListModel = InstantWeatherListModel();

  bool get getInstantWeatherInProgress => _getInstantWeatherInProgress;
  InstantWeatherListModel? get instantWeatherListModel =>
      _instantWeatherListModel;

  Future<bool> getInstantWeather(double latitude, double longitude) async {
    _getInstantWeatherInProgress = true;
    update();

    try {
      final NetworkResponse response = await NetworkCaller.getRequest(
        Urls.getInstantWeather(latitude, longitude),
      ).timeout(const Duration(seconds: 10));

      //_getInstantWeatherInProgress = false;

      if (response.isSuccess && response.responseJson != null) {
        _instantWeatherListModel =
            InstantWeatherListModel.fromJson(response.responseJson!);
        update();
        log('API Response: ${response.responseJson}');
        log('Parsed Model: ${_instantWeatherListModel.toJson()}');

        return true;
      } else {
        log('Failed to fetch hourly weather');
        return false;
      }
    } catch (e) {
     // _getInstantWeatherInProgress = false;
      log('Error fetching hourly weather: $e');
      return false;
    } finally {
      _getInstantWeatherInProgress = false;
      update();
    }
  }
}
