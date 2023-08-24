import 'package:app_api/models/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys { loggedIn, id, fullName, email, gender, token }

class SharedPrfController {
  SharedPrfController._();

  late SharedPreferences _sharedPreferences;

  static SharedPrfController? _instance;

  factory SharedPrfController() {
    return _instance ??= SharedPrfController._();
  }

  Future<void> initSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  T? getVauleFor<T>({required String key}) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T;
    }
    return null;
  }

  void clear() async{
    _sharedPreferences.clear();
  }

  void save(Student student) async {
    await _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
    await _sharedPreferences.setInt(PrefKeys.id.name, student.id);
    await _sharedPreferences.setString(PrefKeys.fullName.name, student.fullName);
    await _sharedPreferences.setString(PrefKeys.email.name, student.email);
    await _sharedPreferences.setString(PrefKeys.gender.name, student.gender);
    await _sharedPreferences.setString(PrefKeys.token.name, 'Bearer ${student.token}');
  }
}
