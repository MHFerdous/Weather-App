import 'dart:async';
import 'dart:developer';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:location/location.dart';
import 'package:weather_app_flutter/data/models/instant_weather_list_model.dart';
import 'package:weather_app_flutter/data/models/hourly_weather_list_model.dart';
import 'package:weather_app_flutter/data/models/network_response.dart';
import 'package:weather_app_flutter/data/services/network_caller.dart';
import 'package:weather_app_flutter/data/utility/urls.dart';
import 'package:weather_app_flutter/presentation/state_holders/hourly_forecast_controller.dart';
import 'package:weather_app_flutter/presentation/state_holders/instant_weather_controller.dart';

class LocationController extends GetxController {
  bool _getLocationInProgress = false;
  bool _getHourlyForecastInProgress = false;
  bool _getInstantWeatherInProgress = false;
/*  InstantWeatherController instantWeatherController =
      InstantWeatherController();
  HourlyForecastController hourlyForecastController =
      HourlyForecastController();*/
  HourlyWeatherListModel _hourlyWeatherListModel = HourlyWeatherListModel();
  InstantWeatherListModel _instantWeatherListModel = InstantWeatherListModel();
  LocationData? _myCurrentLocation;
  StreamSubscription? _locationSubscription;

  bool get locationInProgress => _getLocationInProgress;
  bool get getInstantWeatherInProgress => _getInstantWeatherInProgress;
  bool get getHourlyForecastInProgress => _getHourlyForecastInProgress;
  HourlyWeatherListModel? get hourlyWeatherListModel => _hourlyWeatherListModel;
  InstantWeatherListModel? get instantWeatherListModel =>
      _instantWeatherListModel;
  LocationData? get locationData => _myCurrentLocation;
  StreamSubscription? get streamSubscription => _locationSubscription;

  Future<void> getMyLocation() async {
    _getLocationInProgress = true;
    update();
    try {
      final permissionGranted = await Location.instance.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        log('Location permission not granted.');
        return;
      }
      update();
      _myCurrentLocation = await Location.instance.getLocation();
      log('My Current Location: ${_myCurrentLocation.toString()}');

      if (_myCurrentLocation != null) {
        /*await instantWeatherController.getInstantWeather(
          _myCurrentLocation!.latitude!,
          _myCurrentLocation!.longitude!,
        );*/
        await getInstantWeather();
        await getHourlyWeather();
        /*await hourlyForecastController.getHourlyWeather(
          _myCurrentLocation!.latitude!,
          _myCurrentLocation!.longitude!,
        );*/
      }
      update();
    } catch (e) {
      log('Error getting location: $e');
    }
    _getLocationInProgress = false;
    update();
  }

  void listenToMyLocation() {
    _locationSubscription =
        Location.instance.onLocationChanged.listen((location) {
      if (location.latitude != _myCurrentLocation?.latitude ||
          location.longitude != _myCurrentLocation?.longitude) {
        _myCurrentLocation = location;
        log('Location updated: $location');
        update();
      }
    });
  }

  void stopToListenLocation() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  Future<bool> getInstantWeather() async {
    _getInstantWeatherInProgress = true;
    update();

    try {
      final NetworkResponse response = await NetworkCaller.getRequest(
        Urls.getInstantWeather(
            _myCurrentLocation!.latitude!, _myCurrentLocation!.longitude!),
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

  Future<bool> getHourlyWeather() async {
    _getHourlyForecastInProgress = true;
    update();

    try {
      final NetworkResponse response = await NetworkCaller.getRequest(
        Urls.getHourlyWeather(
            _myCurrentLocation!.latitude!, _myCurrentLocation!.longitude!),
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
    stopToListenLocation();
    super.onClose();
  }
}
