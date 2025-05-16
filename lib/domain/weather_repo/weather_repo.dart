import 'package:flutter_maps/data/model/wether_model.dart';

abstract class WeatherRepo {
  Future<WeatherModel> fetchWeatherData(String cityName);

}