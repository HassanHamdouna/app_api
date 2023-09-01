import 'dart:convert';
import 'dart:io';
import 'package:app_api/api/api_settings.dart';
import 'package:app_api/models/api_respones.dart';
import 'package:app_api/models/student_image.dart';
import 'package:app_api/pref/shared_pref_controller.dart';
import 'package:http/http.dart' as http;

class ImagesApiController{

  Future<ApiRespones<StudentImage>> uploadImage({required String path}) async{
    Uri uri = Uri.parse(ApiSettings.imagesStudent.replaceFirst('/{id}', ''));
    var request =  http.MultipartRequest('POST',uri);
    http.MultipartFile  imageFile = await http.MultipartFile.fromPath('image', path);
    request.files.add(imageFile);
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    request.headers[HttpHeaders.authorizationHeader] = SharedPrfController().getVauleFor<String>(key: PrefKeys.token.name)!;

    var respones = await request.send();
    if(respones.statusCode == 201){
      String body = await respones.stream.transform(utf8.decoder).first;
      var json = jsonDecode(body);
      StudentImage image = StudentImage.fromJson(json['object']);
      return ApiRespones<StudentImage>(json['message'], json['status'],image);
    }
    return ApiRespones('something went Wrong ', false);
  }
}