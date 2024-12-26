class Urls {
  static const String apiKey = '3a42d03e67b300184a6471e3f75b6d83';

  static String getWeather(double lat, lon) =>
      'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey';
}
