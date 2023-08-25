import 'package:app_api/pref/shared_pref_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3),() {
      bool isLogin = SharedPrfController().getVauleFor<bool>(key: PrefKeys.loggedIn.name)?? false ;
      String rout = isLogin? '/users_screen':'/login_screen';
      Navigator.pushReplacementNamed(context, rout);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text('Welcome',style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 40,
          color: Colors.black
        )),
      ),
    );
  }
}
