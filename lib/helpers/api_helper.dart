import 'package:app_api/models/api_respones.dart';

mixin ApiHelper{
  ApiRespones get errorRespoens => ApiRespones('Something went wrong, try again', false);
}