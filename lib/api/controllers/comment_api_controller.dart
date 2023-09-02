import 'dart:convert';

import 'package:app_api/models/comment.dart';
import 'package:http/http.dart' as http;

class CommentApiController {
  Future<List<Comment>> getComments() async {
    Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = List.of(json);
      List<Comment> listUsers =
      dataJsonObject.map((index) => Comment.fromJson(index)).toList();

      return listUsers;
    }
    return [];
  }

}