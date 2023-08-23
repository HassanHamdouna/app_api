import 'package:app_api/screens/app/home_screen.dart';
import 'package:app_api/screens/core/launch_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
        textStyle:  TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,),),
        ),
      ),
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen' : (context) => const LaunchScreen(),
        '/users_screen' : (context) => const UsersScreen(),
      },
    );
  }
}

