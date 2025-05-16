sealed class WeatherEvent {
  const WeatherEvent();
}

class WeatherFetchEvent extends WeatherEvent {
  final cityName;
  const WeatherFetchEvent(this.cityName);
}