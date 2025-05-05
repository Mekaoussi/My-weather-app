import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/weather_forcasting_item.dart';

import 'extra_info.dart';

import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getweather();
  }

  String cityName = "batna".toUpperCase();
  String country = "dz".toUpperCase();
  Future<Map<String, dynamic>> getweather() async {
    try {
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,$country&APPID=ff9d1e3699ece882419f91160421c7bb'));

      final data = jsonDecode(res.body);

      if (data['cod'] != "200") {
        throw 'An unexpected error occured';
      }
      print('data = $data');
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  String ff(String x) {
    String y = "";

    for (int i = 11; i < 16; i++) {
      y += x[i];
    }
    return y;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        centerTitle: true,
        leading: InkWell(
          ///or GestureDetector for MORE Controle but No splash effect
          ///InkWell gives the square splash effect
          child: const Icon(Icons.adjust_rounded),
          onTap: () {},
        ),
        title: const Text(
          "Weather App !",
          style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(220, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: getweather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text(
              snapshot.error.toString(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ));
          }
          final data = snapshot.data!;
          final currentTemp =
              (data["list"][0]["main"]["temp"] - 273.16).toStringAsFixed(2) +
                  "°";
          final currentSky = data["list"][0]["weather"][0]["main"];
          final currentHumidity =
              data["list"][0]["main"]["humidity"].toString();
          final currentWindSpeed =
              (data["list"][0]["wind"]["speed"] * 3.6).toStringAsFixed(2);
          final currentPressur = data["list"][0]["main"]["pressure"].toString();

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "$cityName $country",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    //SizedBox is better then container when u want to only modify width
                    width: double.infinity,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            15,
                          ),
                        ),
                      ),
                      elevation: 7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: BackdropFilter(
                          //for blur
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '$currentTemp C',
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  currentSky == "Clear" || currentSky == "Sunny"
                                      ? Icons.sunny
                                      : Icons.cloud,
                                  size: 64,
                                ),
                                const SizedBox(height: 9), //its like a reward
                                Text(
                                  currentSky,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Weather Forcast",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 1; i <= 39; i++)
                          WeatherForcastitem(
                            time: ff(data["list"][i]['dt_txt'].toString()),
                            state: data["list"][i]["weather"][0]["main"] ==
                                        "Clear" ||
                                    data["list"][i]["weather"][0]["main"] ==
                                        "Sunny"
                                ? Icons.sunny
                                : Icons.cloud,
                            mesure: ((data["list"][i]["main"]["temp"] - 273.15)
                                    .toStringAsFixed(2) +
                                "°"),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Additional Informations",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ExtraInfo(
                        icon: Icons.water_drop,
                        target: "Humidity",
                        degree: currentHumidity,
                      ),
                      ExtraInfo(
                        icon: Icons.air,
                        target: "Wind Speed",
                        degree: "$currentWindSpeed Km/H",
                      ),
                      ExtraInfo(
                        icon: Icons.beach_access,
                        target: "Pressure",
                        degree: currentPressur,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
