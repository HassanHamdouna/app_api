import 'dart:convert';

import 'package:app_api/api/api_settings.dart';
import 'package:app_api/models/api_respones.dart';
import 'package:app_api/models/student.dart';
import 'package:http/http.dart' as http;

class AuthApiController {
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
        //TODO: Save student in Shared Preferences
      }
      return ApiRespones(json['message'], json['status']);
    }
    return ApiRespones('Something went wrong, try again', false);
  }
}
