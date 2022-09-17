import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/model/Weather_model.dart';

class WeatherAPI {
  Future<WeatherModel> getWeather(String city) async {
    final result = await http.Client().get(Uri.parse(
        'https://api.openweathermap.org/data/2...$city&APPID=53a89e20afb9b66c4ac609e1189ee64f'));

    if (result.statusCode != 200) {
      throw Exception();
    } else {
      return prasedJson(result.body);
    }
  }

  WeatherModel prasedJson(final response) {
    final jsonDecoded = json.decode(response);

    final jsonWeather = jsonDecoded["main"];

    return WeatherModel.fromJson(jsonWeather);
  }
}
