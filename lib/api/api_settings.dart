class ApiSettings {
  static const String _baseUrt = 'http://demo-api.mr-dev.tech/api/';
  static const String users = '${_baseUrt}users';
  static const String usersSearch = '${_baseUrt}users/search';
  static const String register = '${_baseUrt}students/auth/register';
  static const String login = '${_baseUrt}students/auth/login';
  static const String logout = '${_baseUrt}students/auth/logout';
  static const String forgetPassword = '${_baseUrt}students/auth/forget-password';

  static const String imagesStudent = '${_baseUrt}student/images/{id}';

}
