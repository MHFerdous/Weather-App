class Urls {
  static const String apiKey = '3a42d03e67b300184a6471e3f75b6d83';

  static String getHourlyWeather(double lat, lon) =>
      'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

  static String getInstantWeather(double lat, lon) =>
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
}
