import 'package:flutter/material.dart';

class Additional extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const Additional({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(children: [
        Icon(icon,size: 35,),
        const SizedBox(height: 7),
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 7),
        Text(
          value,
          style:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}