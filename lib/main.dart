import 'package:app_api/screens/home_screen.dart';
import 'package:app_api/screens/launch_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen' : (context) => const LaunchScreen(),
        '/home_screen' : (context) => const HomeScreen(),
      },
    );
  }
}

