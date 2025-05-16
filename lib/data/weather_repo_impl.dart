import 'package:flutter_maps/data/model/wether_model.dart';
import 'package:flutter_maps/data/remote_data_source.dart';

class WeatherRepoImpl {
  final RemoteDataSourceImpl remoteDataSource = RemoteDataSourceImpl();

  Future<WeatherModel> fetchWeatherData(String cityName) async {
    try {
      final weatherData = await remoteDataSource.fetchWeatherData(cityName);
      return weatherData;
    } catch (e) {
      // Handle error
      rethrow;
    }
  }
}