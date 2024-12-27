import 'package:get/get.dart';
import 'package:weather_app_flutter/presentation/state_holders/hourly_forecast_controller.dart';
import 'package:weather_app_flutter/presentation/state_holders/instant_weather_controller.dart';
import 'package:weather_app_flutter/presentation/state_holders/location_controller.dart';

class StateHolderBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationController());
/*    Get.put(InstantWeatherController());
    Get.put(HourlyForecastController());*/
  }
}
