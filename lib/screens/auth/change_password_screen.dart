import 'package:app_api/api/controllers/auth_api_controller.dart';
import 'package:app_api/helpers/context_extenssion.dart';
import 'package:app_api/models/api_respones.dart';
import 'package:app_api/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
   ChangePasswordScreen({super.key, this.code});

   String? code ;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _emailController;
  late TextEditingController _codeController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _codeController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
              children: [
                const SizedBox(
                  height: 70,
                ),
                Text('Change Password ${widget.code!}',
                    style: GoogleFonts.ubuntu(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff0B2E40),
                    )),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 29,
                ),
                AppTextField(
                  hint: 'email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.name,
                  focusedBorderColor: const Color(0xffEDEDED),
                  obscureText: false,
                  suffixIcon: null,
                  controller: _emailController,
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppTextField(
                  hint: 'code',
                  prefixIcon: Icons.code,
                  keyboardType: TextInputType.number,
                  focusedBorderColor: const Color(0xffEDEDED),
                  obscureText: false,
                  suffixIcon: null,
                  controller: _codeController,
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppTextField(
                  hint: 'new password',
                  prefixIcon: Icons.lock,
                  keyboardType: TextInputType.name,
                  focusedBorderColor: const Color(0xffEDEDED),
                  obscureText: false,
                  suffixIcon: null,
                  controller: _newPasswordController,
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppTextField(
                  hint: 'confirm password',
                  prefixIcon: Icons.lock,
                  keyboardType: TextInputType.name,
                  focusedBorderColor: const Color(0xffEDEDED),
                  obscureText: false,
                  suffixIcon: null,
                  controller: _confirmPasswordController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _performChangePassword();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      ),
                  child: Text(
                    'change Password',
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

  void _performChangePassword() {
    if (_checkDate()) {
      _changePassword();
    }
  }

  bool _checkDate() {
    if (_emailController.text.isNotEmpty && _codeController.text.isNotEmpty && _newPasswordController.text.isNotEmpty && _confirmPasswordController.text.isNotEmpty) {
      if (_newPasswordController.text == _confirmPasswordController.text) {
        return _checkCode();
      }
      context.showSnackBar(message: ' newPassword != confirmPassword', error: true);
      return false;


    }
    context.showSnackBar(message: 'Enter required data', error: true);

    return false;
  }

  bool _checkCode(){
    if(_codeController.text.toString() == widget.code){
      return true;
    }
    context.showSnackBar(message: 'The code is error', error: true);
    return false;
  }

  void _changePassword() async {
    ApiRespones respones = await AuthApiController().changePassword(email: _emailController.text, code: _codeController.text, password: _newPasswordController.text, passwordConfirmation: _confirmPasswordController.text);
    if(respones.status){
      Navigator.pop(context);
    }
    context.showSnackBar(message: respones.message, error: !respones.status);
  }
}
