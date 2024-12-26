import 'dart:async';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:location/location.dart';
import 'package:weather_app_flutter/data/models/instant_weather_list_model.dart';
import 'package:weather_app_flutter/data/models/network_response.dart';
import 'package:weather_app_flutter/data/models/hourly_weather_list_model.dart';
import 'package:weather_app_flutter/data/services/network_caller.dart';
import 'package:weather_app_flutter/data/utility/urls.dart';

class LocationController extends GetxController {
  bool _getWeatherInProgress = false;
  HourlyWeatherListModel _hourlyWeatherListModel = HourlyWeatherListModel();
  InstantWeatherListModel _instantWeatherListModel = InstantWeatherListModel();
  LocationData? _myCurrentLocation;
  StreamSubscription? _locationSubscription;

  bool get getCartListInProgress => _getWeatherInProgress;
  HourlyWeatherListModel? get hourlyWeatherListModel => _hourlyWeatherListModel;
  InstantWeatherListModel? get instantWeatherListModel =>
      _instantWeatherListModel;
  LocationData? get locationData => _myCurrentLocation;
  StreamSubscription? get streamSubscription => _locationSubscription;

  void getMyLocation() async {
    await Location.instance.requestPermission().then((requestedPermission) {
      print(requestedPermission);
    });
    await Location.instance.hasPermission().then((permissionStatus) {
      print(permissionStatus);
    });
    _myCurrentLocation = await Location.instance.getLocation();
    print(_myCurrentLocation);
    getInstantWeather();
    getHourlyWeather();
    update();
  }

  Future<bool> getHourlyWeather() async {
    _getWeatherInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        Urls.getHourlyWeather(
            _myCurrentLocation!.latitude!, _myCurrentLocation!.longitude!));
    _getWeatherInProgress = false;
    if (response.isSuccess) {
      _hourlyWeatherListModel =
          HourlyWeatherListModel.fromJson(response.responseJson!);

      update();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getInstantWeather() async {
    _getWeatherInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        Urls.getInstantWeather(
            _myCurrentLocation!.latitude!, _myCurrentLocation!.longitude!));
    _getWeatherInProgress = false;
    if (response.isSuccess) {
      _instantWeatherListModel =
          InstantWeatherListModel.fromJson(response.responseJson!);

      update();
      return true;
    } else {
      return false;
    }
  }

  void listenToMyLocation() {
    _locationSubscription =
        Location.instance.onLocationChanged.listen((location) {
      if (location != _myCurrentLocation) {
        _myCurrentLocation = location;
        print('listening to location $location');
        update();
      }
    });
  }

  void stopToListenLocation() {
    _locationSubscription?.cancel();
  }
}
