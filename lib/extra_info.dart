import 'package:flutter/material.dart';

class ExtraInfo extends StatelessWidget {
  final IconData icon;
  final String target;
  final String degree;

  const ExtraInfo(
      {super.key,
      required this.icon,
      required this.target,
      required this.degree});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 50,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          target,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          degree,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
