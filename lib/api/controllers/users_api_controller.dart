import 'dart:convert';

import 'package:app_api/api/api_settings.dart';
import 'package:app_api/models/user.dart';
import 'package:http/http.dart' as http;

class UserApiController {
  /// New Ani Request:
  /// 1) Convent URI in APTSettings from String to URI
  /// 2) Detect request method. (Get/Past /Put/Patch /Delete)
  /// 3) Create new ani request using http method (uri)
  /// 4) The created requests is async future<Response> that returns a response object.
  /// 5) Ensure that the request completed successfully by checking the status code.
  /// 6) If successfully executed, get the response body
  ///    => Convert response body from string to JSON using decode

  Future<List<User>> getUsers() async {
    Uri uri = Uri.parse(ApiSettings.users);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['data'] as List;
      List<User> listUsers =
          dataJsonObject.map((index) => User.fromJson(index)).toList();
      return listUsers;
    }
    return [];
  }

  Future<List<User>> getUsersSearch(
      {required String firstName, required String jobTitle}) async {
    Uri uri = Uri.parse(ApiSettings.usersSearch);
    var respones = await http.post(uri, body: {
      'first_name': firstName,
      'job_title': jobTitle,
    });
    if (respones.statusCode == 200) {
      var json = jsonDecode(respones.body);
      var dataJsonObject = json['data'] as List;
      try {
        List<User> listUsers =
            dataJsonObject.map((index) => User.fromJson(index)).toList();
        return listUsers;
      } catch (e) {
        print('Error creating User objects: $e');
      }
    }
    return [];
  }
}
