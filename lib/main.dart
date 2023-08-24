import 'package:app_api/screens/app/user_screen.dart';
import 'package:app_api/screens/auth/change_password_screen.dart';
import 'package:app_api/screens/auth/forget_password_screen.dart';
import 'package:app_api/screens/auth/login_screen.dart';
import 'package:app_api/screens/auth/register_screen.dart';
import 'package:app_api/screens/core/launch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            backgroundColor: Colors.white,
            textTheme: TextTheme(
              bodyLarge: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen': (context) => const LaunchScreen(),
            '/users_screen': (context) => const UsersScreen(),

            '/login_screen': (context) => const LoginScreen(),
            '/register_screen': (context) => const RegisterScreen(),
            '/change_password_screen': (context) => const ChangePasswordScreen(),
            '/forget_password_screen': (context) => const ForgotPasswordScreen(),
          },
        );
      },
    );
  }
}
