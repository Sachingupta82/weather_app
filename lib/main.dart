import 'package:flutter/material.dart';
import 'package:weather_app/view/first_screen.dart';

void main(){
  runApp(const weather());
}

class weather extends StatelessWidget {
  const weather({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Appa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        // appBarTheme: AppBarTheme(backgroundColor: Colors.black),
        // useMaterial3: true,
      ),
      home: const first_screen(),
    );
  }
}