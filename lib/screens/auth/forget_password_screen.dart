import 'package:app_api/api/controllers/auth_api_controller.dart';
import 'package:app_api/helpers/context_extenssion.dart';
import 'package:app_api/models/api_respones.dart';
import 'package:app_api/screens/auth/change_password_screen.dart';
import 'package:app_api/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

late TextEditingController _emailController;

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        leadingWidth: 80,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Text('Forgot Password',
                    style: GoogleFonts.ubuntu(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff0B2E40),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    'Please enter your email address. You will receive a link to create new password via email',
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff7E7B7B),
                    )),
                const SizedBox(
                  height: 29,
                ),
                AppTextField(
                  hint: 'Email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.name,
                  focusedBorderColor: const Color(0xffEDEDED),
                  obscureText: false,
                  suffixIcon: null,
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _performForgotPassword();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                  ),
                  child: Text(
                    'Reset Password',
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: const Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _performForgotPassword() {
    if (_checkDate()) {
      _forgotPassword();
    }
  }

  bool _checkDate() {
    if (_emailController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter required data', error: true);
    return false;
  }

  void _forgotPassword() async {
    ApiRespones respones  = await AuthApiController().forgetPassword(email: _emailController.text);
    if(respones.status){
      print('respones: ${respones}');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChangePasswordScreen(code: '${respones.message}'),
          ));
    }
    context.showSnackBar(message: respones.message, error: !respones.status);

  }

}
