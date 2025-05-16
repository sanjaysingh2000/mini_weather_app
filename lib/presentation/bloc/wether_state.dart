import 'package:flutter_maps/data/model/wether_model.dart';

sealed class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherLoaded extends WeatherState {
  final WeatherModel weatherData;
  const WeatherLoaded(this.weatherData);
}

class WeatherError extends WeatherState {
  final String error;
  const WeatherError(this.error);
}

