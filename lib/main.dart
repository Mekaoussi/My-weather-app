// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'weather_screen.dart';

void main() {
  runApp(const weatherAPP());
}

class weatherAPP extends StatelessWidget {
  const weatherAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
    );
  }
}
