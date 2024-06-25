import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Weather? weather;
  final openweather = WeatherFactory('5a69e4a5e1200bb0335e74405119ecb8');
  String cityName = '';

  getweather() async {
    try {
      weather = await openweather.currentWeatherByCityName(cityName);
      setState(() {});
    } catch (e) {
      print("The error is $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        title: Text("Search City Name "),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  cityName = value;
                });
              },
              decoration: InputDecoration(
                  hintText: "Search by city name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      getweather();
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.cyan,
                    ),
                  )),
            ),
          ),
          Expanded(
              child: weather != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${weather!.temperature!.celsius!.round()} *C',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text('${weather!.weatherDescription}'),
                      ],
                    )
                  : SizedBox()),
        ],
      ),
    );
  }
}
