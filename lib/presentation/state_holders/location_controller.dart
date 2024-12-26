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

  void getMyLocation() async {
    await Location.instance.requestPermission().then((requestedPermission) {
      log(requestedPermission.toString());
    });
    await Location.instance.hasPermission().then((permissionStatus) {
      log(permissionStatus.toString());
    });
    _myCurrentLocation = await Location.instance.getLocation();
    log(_myCurrentLocation.toString());
    await instantWeatherController.getInstantWeather();
    await hourlyForecastController.getHourlyWeather();
    update();
  }

  void listenToMyLocation() {
    _locationSubscription =
        Location.instance.onLocationChanged.listen((location) {
      if (location != _myCurrentLocation) {
        _myCurrentLocation = location;
        log('listening to location $location');
        update();
      }
    });
  }

  void stopToListenLocation() {
    _locationSubscription?.cancel();
  }
}
