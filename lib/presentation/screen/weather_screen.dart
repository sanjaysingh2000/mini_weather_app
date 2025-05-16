import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/presentation/bloc/weather_bloc.dart';
import 'package:flutter_maps/presentation/bloc/weather_event.dart';
import 'package:flutter_maps/presentation/bloc/wether_state.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  final TextEditingController _cityNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Screen'),
      ),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Weather Screen',
              style: TextStyle(fontSize: 24),
            ),
            TextFormField(
              controller: _cityNameController,
              decoration: const InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
               context.read<WeatherBloc>().add(WeatherFetchEvent(_cityNameController.text));
              },
              child: const Text('Fetch Weather'),
            ),
            BlocConsumer<WeatherBloc, WeatherState>(
              listener: (context, state) {
                  if (state is WeatherError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('Error: ${state.error}'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  return Column(
                    children: [
                      Text('City: ${state.weatherData.location?.name}'),
                      Text('Temperature: ${state.weatherData.current?.tempC}°C'),
                      Text('Condition: ${state.weatherData.current?.condition?.text}'),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}