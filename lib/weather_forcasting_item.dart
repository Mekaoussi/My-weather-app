import 'package:flutter/material.dart';

class WeatherForcastitem extends StatelessWidget {
  final String time;
  final IconData state;
  final String mesure;

  const WeatherForcastitem(
      {super.key,
      required this.time,
      required this.state,
      required this.mesure});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                time,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Icon(
                state,
                size: 45,
              ),
              const SizedBox(
                height: 11,
              ),
              Text(
                mesure,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
