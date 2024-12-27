import 'dart:async';
import 'dart:developer';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:location/location.dart';
import 'package:weather_app_flutter/data/models/instant_weather_list_model.dart';
import 'package:weather_app_flutter/data/models/hourly_weather_list_model.dart';
import 'package:weather_app_flutter/presentation/state_holders/hourly_forecast_controller.dart';
import 'package:weather_app_flutter/presentation/state_holders/instant_weather_controller.dart';

class LocationController extends GetxController {
  InstantWeatherController instantWeatherController =
      InstantWeatherController();
  HourlyForecastController hourlyForecastController =
      HourlyForecastController();
  final HourlyWeatherListModel _hourlyWeatherListModel =
      HourlyWeatherListModel();
  final InstantWeatherListModel _instantWeatherListModel =
      InstantWeatherListModel();
  LocationData? _myCurrentLocation;
  StreamSubscription? _locationSubscription;

  HourlyWeatherListModel? get hourlyWeatherListModel => _hourlyWeatherListModel;
  InstantWeatherListModel? get instantWeatherListModel =>
      _instantWeatherListModel;
  LocationData? get locationData => _myCurrentLocation;
  StreamSubscription? get streamSubscription => _locationSubscription;

  Future<void> getMyLocation() async {
    try {
      final permissionGranted = await Location.instance.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        log('Location permission not granted.');
        return;
      }

      _myCurrentLocation = await Location.instance.getLocation();
      log('Current Location: ${_myCurrentLocation.toString()}');

      if (_myCurrentLocation != null) {
        await instantWeatherController.getInstantWeather(
          _myCurrentLocation!.latitude!,
          _myCurrentLocation!.longitude!,
        );
        await hourlyForecastController.getHourlyWeather(
          _myCurrentLocation!.latitude!,
          _myCurrentLocation!.longitude!,
        );
      }
      update();
    } catch (e) {
      log('Error getting location: $e');
    }
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

  @override
  void onClose() {
    stopToListenLocation();
    super.onClose();
  }
}
