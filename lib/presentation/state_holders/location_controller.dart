import 'dart:async';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:location/location.dart';
import 'package:weather_app_flutter/data/models/network_response.dart';
import 'package:weather_app_flutter/data/models/weather_model.dart';
import 'package:weather_app_flutter/data/services/network_caller.dart';
import 'package:weather_app_flutter/data/utility/urls.dart';

class LocationController extends GetxController {
  bool _getWeatherInProgress = false;
  WeatherListModel _weatherListModel = WeatherListModel();
  LocationData? _myCurrentLocation;
  StreamSubscription? _locationSubscription;

  bool get getCartListInProgress => _getWeatherInProgress;
  WeatherListModel? get weatherListModel => _weatherListModel;
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
    getWeather();
    update();
  }

  Future<bool> getWeather() async {
    _getWeatherInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        Urls.getWeather(
            _myCurrentLocation!.latitude!, _myCurrentLocation!.longitude!));
    _getWeatherInProgress = false;
    if (response.isSuccess) {
      _weatherListModel = WeatherListModel.fromJson(response.responseJson!);

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
