import 'dart:convert';
import 'dart:io';

import 'package:app_api/api/api_settings.dart';
import 'package:app_api/helpers/api_helper.dart';
import 'package:app_api/models/api_respones.dart';
import 'package:app_api/models/student.dart';
import 'package:app_api/pref/shared_pref_controller.dart';
import 'package:http/http.dart' as http;

class AuthApiController with ApiHelper {
  /// New Ani Request:
  /// 1) Convent URI in APTSettings from String to URI
  /// 2) Detect request method. (Get/Past /Put/Patch /Delete)
  /// 3) Create new ani request using http method (uri)
  ///     => In case the request must have a body, set request body  using body param in http.method function
  ///     => body will request a map of key: value
  ///     => keys are defined by web developer, must be same as defined in postman
  ///     => values are the data entered from UI.
  /// 4) The created requests is async future<Response> that returns a response object.
  /// 5) Ensure that the request completed successfully by checking the status code.
  /// 6) If successfully executed, get the response body
  ///    => Convert response body from string to JSON using decode

  Future<ApiRespones> login(
      {required String email, required String password}) async {
    Uri uri = Uri.parse(ApiSettings.login);
    var respones = await http.post(uri, body: {
      'email': email,
      'password': password,
    });
    if (respones.statusCode == 200 || respones.statusCode == 400) {
      var json = jsonDecode(respones.body);
      if (respones.statusCode == 200) {
        Student student = Student.fromJson(json(['object']));
        SharedPrfController().save(student);
      }
      return ApiRespones(json['message'], json['status']);
    }
    return errorRespoens;
  }

  Future<ApiRespones> register(Student student) async {
    Uri uri = Uri.parse(ApiSettings.register);
    var response = await http.post(uri, body: {
      'full_name': student.fullName,
      'email': student.email,
      'password': student.password,
      'gender': student.gender,
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      return ApiRespones(json['message'], json['status']);
    }
    return errorRespoens;
  }

  Future<ApiRespones> logOut() async {
    String token =
        SharedPrfController().getVauleFor<String>(key: PrefKeys.token.name)!;
    Uri uri = Uri.parse(ApiSettings.logout);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/json',
    });
    if (response.statusCode == 200 || response.statusCode == 401) {
      SharedPrfController().clear();
      return ApiRespones('Logged out successfully', true);
    }
    return errorRespoens;
  }
}
