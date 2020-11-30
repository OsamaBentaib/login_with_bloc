import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc_login/model/signup_api_model.dart';


final _base = "https://isfortest.herokuapp.com/";
final _tokenEndpoint = "rest-auth/registration/";
final _tokenURL = _base + _tokenEndpoint;

Future<Token> getToken(UserSignUp userSignUp) async {
  print(_tokenURL);
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userSignUp.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
