import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:weather_app_flutter/data/models/network_response.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(
        Uri.parse(url),
      );
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        log(response.statusCode.toString());

        return NetworkResponse(
          true,
          response.statusCode,
          jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          false,
          response.statusCode,
          null,
        );
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  static Future<NetworkResponse> postRequest(
      String url, Map<String, dynamic> body,
      {bool isLogin = false}) async {
    try {
      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
      );
      log(
        response.statusCode.toString(),
      );
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          true,
          response.statusCode,
          jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          false,
          response.statusCode,
          null,
        );
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }
}
