import 'package:dio/dio.dart';
import 'package:flutter_maps/core/constants/api_key.dart';
import 'package:flutter_maps/data/model/wether_model.dart';

abstract class RemoteDataSource {
  Future<WeatherModel> fetchWeatherData(String cityName);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override

  Future<WeatherModel> fetchWeatherData(String cityName) async{

     final response = await Dio().get(
      
      '${AppConstants.weatherBaseUrl}/current.json?key=${AppConstants.weatherKey} &q=$cityName',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    if(response.statusCode==200){
      return WeatherModel.fromJson(response.data);
    }
    return WeatherModel(
      location: Location(name: 'Unknown', region: 'Unknown', country: 'Unknown'),
      current: Current(tempC: 0.0, condition: Condition(text: 'Unknown')),
    );
   }
  
  }