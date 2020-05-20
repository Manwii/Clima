import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationinfo});
  final locationinfo;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather=WeatherModel();
  String cityname;
  String weatherIcon;
  int temperature;
  String weathermessage;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationinfo);
  }
  @override
  void updateUI(dynamic weatherdata){
    setState(() {
      if(weatherdata==null){
        temperature=0;
        weatherIcon='Error';
        cityname='';
        weathermessage='Unable to get weather data';
        return;
      }
      var temp=weatherdata['main']['temp'];
      temperature=temp.toInt();
      cityname=weatherdata['name'];
      var  weatherid=weatherdata['weather'][0]['id'];
      weatherIcon=weather.getWeatherIcon(weatherid);
      weathermessage=weather.getMessage(temperature);
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherdata=await weather.getWeatherData();
                      updateUI(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                     var typedname= await Navigator.push(context, MaterialPageRoute(builder:(context){
                        return CityScreen();
                      }));
                     if(typedname!=null)
                     {
                       var weatherdata=await weather.getCityWeather(typedname);
                       updateUI(weatherdata);
                     }
                    },

                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weathermessage in $cityname!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
