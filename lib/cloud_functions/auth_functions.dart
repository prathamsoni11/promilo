import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class AuthFunctions {
  Future<http.Response> oAuth(String emailOrMob, String password) async {
    const String apiUrl = 'https://apiv2stg.promilo.com/user/oauth/token';
    const String authorizationHeader = 'Basic UHJvbWlsbzpxNCE1NkBaeSN4MiRHQg==';

    String hashedPassword = sha256.convert(utf8.encode(password)).toString();

    Map<String, String> body = {
      "username": emailOrMob,
      "password": hashedPassword,
      'grant_type': 'password',
    };

    var res = await http.post(
      Uri.parse(apiUrl),
      body: body,
      headers: {
        'Authorization': authorizationHeader,
      },
    );

    return res;
  }
}
