import 'package:flutter/material.dart';

class Forecastcard extends StatelessWidget {
  final String degree;
  final IconData weathicon;
  final String weathtime;
  const Forecastcard({
    required this.degree,
    required this.weathicon,
    required this.weathtime,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                degree,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Icon(weathicon, size: 32),
              const SizedBox(height: 6),
              Text(weathtime , style:const TextStyle(overflow: TextOverflow.clip,fontSize: 15),maxLines: 1,),
            ],
          ),
        ),
      ),
    );
  }
}