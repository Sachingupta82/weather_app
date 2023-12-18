// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/view/additional_info.dart';
import 'package:weather_app/view/forecastcards.dart';
import 'package:http/http.dart' as http;

class first_screen extends StatefulWidget {
  const first_screen({super.key});

  @override
  State<first_screen> createState() => _first_screenState();
}

class _first_screenState extends State<first_screen> {
  double temp = 0;
  String location = 'Mumbai';
  // @override
  // void initState() {
  //   super.initState();
  //   weather_Data();
  // }

  Future<Map<String, dynamic>> weather_Data() async {
    try {
      final data_1 = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?q=$location&APPID=  '),
      ); //we have to pass the url here in uri.parse
      // print(data_1.body);
      final dataLast = jsonDecode(data_1.body);
      if (dataLast['cod'] != '200') {
        throw ('An unexpected error occured');
      }
      return dataLast;
      // temp=dataLast['list'][0]['main']['temp'];
      //returns the detailed data or only required data
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather Appa'),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
          future: weather_Data(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //if the future function is loading this function will be called
              return const Center(
                child: CircularProgressIndicator
                    .adaptive(), //adaptive shows refresh indicator design according to mobile OS
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            final data = snapshot.data!;
            final temp = data['list'][0]['main']['temp'];
            final currentsky = data['list'][0]['weather'][0]['main'];
            final currentpressure = data['list'][0]['main']['pressure'];
            final currentwind = data['list'][0]['wind']['speed'];
            final currenthumidity = data['list'][0]['main']['humidity'];
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text(
                                  '${(temp - 273.15).toStringAsFixed(2)}°C',
                                  // '300.00°C',
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Icon(
                                    currentsky == 'Clouds' ||
                                            currentsky == 'Clear'
                                        ? Icons.cloud
                                        : Icons.bolt,
                                    size: 64),
                                const SizedBox(height: 10),
                                Text(currentsky, style: TextStyle(fontSize: 20))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Weather Forecast',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final iconstatus =
                              data['list'][index + 1]['weather'][0]['main'];
                          final time =
                              DateTime.parse(data['list'][index + 1]['dt_txt']);
                          return Forecastcard(
                            degree:
                                '${(data['list'][index + 1]['main']['temp'] - 273.15).toStringAsFixed(2)}°C',
                            weathicon:
                                iconstatus == 'Clouds' || iconstatus == 'Clear'
                                    ? Icons.cloud
                                    : iconstatus == 'Sunny'
                                        ? Icons.sunny
                                        : Icons.bolt,
                            weathtime: DateFormat.j().format(time),
                          );
                        }),
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for(int i=0;i<5;i++)
                  //       Forecastcard(
                  //         degree: '${(data['list'][0+i]['main']['temp'] - 273.15).toStringAsFixed(2)}°C',
                  //         weathicon: Icons.sunny,
                  //         weathtime: data['list'][0+i]['weather'][0]['main'],
                  //       ),

                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  const Text(
                    'Additional Information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Additional(
                          icon: Icons.water_drop,
                          label: 'Humidity',
                          value: currenthumidity.toString()),
                      Additional(
                          icon: Icons.air,
                          label: 'Wind Speed',
                          value: currentwind.toString()),
                      Additional(
                          icon: Icons.beach_access,
                          label: 'Pressure',
                          value: currentpressure.toString()),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
