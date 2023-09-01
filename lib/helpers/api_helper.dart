import 'dart:io';

import 'package:app_api/models/api_respones.dart';
import 'package:app_api/pref/shared_pref_controller.dart';

mixin ApiHelper{
  ApiRespones get errorRespoens => ApiRespones('Something went wrong, try again', false);
  Map<String,String> get headers => {
    HttpHeaders.acceptHeader : 'application/json',
    HttpHeaders.authorizationHeader: SharedPrfController().getVauleFor<String>(key: PrefKeys.token.name)!
  };
}