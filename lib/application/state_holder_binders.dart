import 'package:get/get.dart';
import 'package:weather_app_flutter/presentation/state_holders/location_controller.dart';

class StateHolderBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationController());
  }
}
