import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weatherFuture;

  Future<Map<String, dynamic>> fetchWeatherData() async {
    try {
      const String defaultCity = 'London';
      final apiResponse = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$defaultCity,uk&APPID=$openWeatherAPIKey',
        ),
      );
      final responseData = jsonDecode(apiResponse.body);

      if (responseData['cod'] != '200') {
        throw 'Failed to fetch weather data';
      }

      return responseData;
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weatherFuture = fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weatherFuture = fetchWeatherData();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final weatherResponse = snapshot.data;
          final currentForecast = weatherResponse?['list'][0];
          final currentTemperature = currentForecast['main']['temp'];
          final weatherDescription = currentForecast['weather'][0]['main'];
          final atmosphericPressure = currentForecast['main']['pressure'];
          final currentWindSpeed = currentForecast['wind']['speed'];
          final humidityLevel = currentForecast['main']['humidity'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main weather card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemperature °K',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Icon(
                                weatherDescription == 'Clouds' ||
                                        weatherDescription == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                weatherDescription,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Hourly forecast section
                const Text(
                  'Hourly Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: weatherResponse?['list'].length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final hourlyForecast =
                          weatherResponse?['list'][index + 1];
                      final hourlyWeatherCondition =
                          weatherResponse?['list'][index +
                              1]['weather'][0]['main'];
                      final hourlyTempValue =
                          hourlyForecast['main']['temp'].toString();
                      final forecastTimestamp = DateTime.parse(
                        hourlyForecast['dt_txt'],
                      );
                      return HourlyForecastItem(
                        time: DateFormat.Hm().format(forecastTimestamp),
                        icon:
                            hourlyWeatherCondition == 'Clouds' ||
                                    hourlyWeatherCondition == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                        value: hourlyTempValue,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Weather metrics section
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: humidityLevel.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: atmosphericPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
