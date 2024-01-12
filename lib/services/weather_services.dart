import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:minimal_weather/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  static const baseUrl =
      "https://api.seniverse.com/v3/weather/now.json?key=SsPBMHVuiQSC_wzrR&language=zh-Hans&unit=c";

  WeatherServices();

  Future<String> getCurrentCity() async {
    // get permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch the current location
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // convert the location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // extract the city name fomr the first placemark
    String? city = placemarks[0].locality;

    return city ?? "city not found";
  }

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$baseUrl&location=$cityName'));
    switch (response.statusCode) {
      case 200:
        return Weather.fromJson(jsonDecode(response.body));
      default:
        throw Exception('Failed to load weather data');
      // return Weather(cityName: "cityName", temperature: 0.2, mainCodition: "mainCodition");
    }
  }
}
