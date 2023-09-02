import 'package:app_api/api/controllers/auth_api_controller.dart';
import 'package:app_api/helpers/context_extenssion.dart';
import 'package:app_api/models/api_respones.dart';
import 'package:app_api/models/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('register'),
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'register_title',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'register_subtitle',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  hint: 'name',
                  prefixIcon: Icons.person,
                  keyboardType: TextInputType.name,
                  controller: _nameTextController,
                ),
                SizedBox(height: 10.h),
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
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () => _performRegister(),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r))),
                  child: Text(
                    'register',
                    style: GoogleFonts.cairo(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void _performRegister() async {
    if (_checkData()) {
      _register();
    }
  }

  bool _checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter required data', error: true);

    return false;
  }

  void _register() async {
    ApiRespones respones = await AuthApiController().register(student);
    if(respones.status){
      Navigator.pop(context);
    }
    context.showSnackBar(message: respones.message, error: !respones.status);
  }
  Student get student {
    Student student = Student();
    student.email = _emailTextController.text;
    student.fullName = _nameTextController.text;
    student.password = _passwordTextController.text;
    student.gender = 'M';
    return student;
  }
  void clearEditText() {
    _nameTextController.text = '';
    _emailTextController.text = '';
    _passwordTextController.text = '';
  }
}
