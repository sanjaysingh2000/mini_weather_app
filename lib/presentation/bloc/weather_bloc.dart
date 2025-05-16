import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/data/weather_repo_impl.dart';
import 'package:flutter_maps/presentation/bloc/weather_event.dart';
import 'package:flutter_maps/presentation/bloc/wether_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepoImpl weatherRepoImpl = WeatherRepoImpl();
  WeatherBloc() : super(const WeatherInitial()) {
    on<WeatherFetchEvent>((event, emit) async {
      try {
        emit(const WeatherLoading());
        final respomse = await weatherRepoImpl
            .fetchWeatherData(event.cityName)
            .then((value) {
          emit(WeatherLoaded(value));
        });
      } on DioException catch (e) {
        if (e.response != null && e.response!.data != null) {
          final errorData = e.response!.data;
          final errorMessage = errorData['error']?['message'];
          print('Eansdkjadrror: $errorMessage'); // prints: API key has been disabled.
          emit(WeatherError(errorMessage));
        }
      }
    });
  }
}
