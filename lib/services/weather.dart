import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';
const apikey='76fb56307e30999502d1dac8a1c35a53';
const OpenMapURL='https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var CityData;
    NetworkHelper nethelp = await NetworkHelper(
        url: '$OpenMapURL?q=$cityName&appid=$apikey&units=metric');
     CityData=nethelp.getData();
    return CityData;
  }
  Future<dynamic> getWeatherData() async{
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper nethelp = NetworkHelper(
        url: '$OpenMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    var weatherdata = await nethelp.getData();
    return weatherdata;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦icecream time';
    } else if (temp > 20) {
      return 'Time for shorts and t-shirt👕';
    } else if (temp < 10) {
      return 'You\'ll need warm clothes🧣 🧤';
    } else {
      return 'Bring a coat🧥 just in case';
    }
  }
}
