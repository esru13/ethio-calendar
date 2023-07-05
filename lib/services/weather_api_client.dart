import 'dart:convert';

import 'package:ethio_calend/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient{
  Future<Weather>? getCurrentweather (String? location) async{
    var endpoint = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=b0143a78f8da2a118e9b7068a71b33bc&units=metric");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);

    return Weather.fromJson(body);
  }
}