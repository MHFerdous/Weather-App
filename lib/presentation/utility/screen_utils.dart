enum DeviceType { smallPhone, phone }

class ScreenUtils {
  static const double smallPhoneMaxSize = 480;
  static const double phoneMaxSize = 640;

  static DeviceType getDeviceType(double width) {
    if (width < ScreenUtils.smallPhoneMaxSize) {
      return DeviceType.smallPhone;
    }
    return DeviceType.phone;
  }
}
