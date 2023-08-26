import 'package:app_api/api/controllers/auth_api_controller.dart';
import 'package:app_api/helpers/context_extenssion.dart';
import 'package:app_api/models/api_respones.dart';
import 'package:app_api/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  bool _obscure = true;
  late String _language;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'login_title',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
              ),
              Text(
                'login_subtitle',
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 20.h),
              AppTextField(
                hint: 'email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: _emailTextController,
              ),
              SizedBox(height: 10.h),
              AppTextField(
                hint: 'password',
                obscureText: _obscure,
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.text,
                controller: _passwordTextController,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() => _obscure = !_obscure);
                  },
                  icon: const Icon(Icons.visibility),
                ),
              ),
              SizedBox(height: 5.h),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/forget_password_screen'),
                    child: Text(
                      'Forget Password ?',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                    )),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () => _performLogin(),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r))),
                child: Text(
                  'login',
                  style: GoogleFonts.poppins(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('new_account_message'),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/register_screen'),
                    child: Text('create_account'),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performLogin() {
    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter required data', error: true);
    return false;
  }

  void _login() async {
    ApiRespones respones = await AuthApiController().login(email: _emailTextController.text, password: _passwordTextController.text);
    if(respones.status){
      Navigator.pushReplacementNamed(context, '/users_screen');
    }
    context.showSnackBar(message: respones.message, error: !respones.status);

  }

  void clearEditText() {
    _emailTextController.text = '';
    _passwordTextController.text = '';
  }
}
