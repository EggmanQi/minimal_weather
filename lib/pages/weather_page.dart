import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather/models/weather_model.dart';
import 'package:minimal_weather/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherServices();
  Weather? _weather;

  _fetchWeather() async {
    // String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather("guangzhou");
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
      setState(() {
        _weather = Weather.error();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Minimal Weather'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? 'Loading...'),
            Lottie.asset(_weather?.getWeatherAnimationJSONPath() ?? "assets/default.json"),
            Text('${_weather?.temperature} 度'),
            Text(_weather?.mainCodition ?? "")
          ],
        ),
      ),
    );
  }
}
