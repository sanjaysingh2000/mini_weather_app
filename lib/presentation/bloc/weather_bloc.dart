import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/data/weather_repo_impl.dart';
import 'package:flutter_maps/presentation/bloc/weather_event.dart';
import 'package:flutter_maps/presentation/bloc/wether_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final WeatherRepoImpl weatherRepoImpl = WeatherRepoImpl();
  WeatherBloc() : super(const WeatherInitial()) {
    on<WeatherFetchEvent>((event, emit) async{
      emit(const WeatherLoading());
      await weatherRepoImpl.fetchWeatherData(event.cityName).then((value) {
        emit(WeatherLoaded(value));
      }).catchError((error) {
        print('api error: $error');
        emit(WeatherError(error.toString()));
      },);
    });
  }
}