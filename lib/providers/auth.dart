import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//
import '../modals/httpDeleteProdException.dart';
class Auth with ChangeNotifier {
  late String _token;
  late String _userId;
  late String _expireDate;

  Future<void> _authenticate(
      String email, String password, String httpUrl) async {
    final url = Uri.parse(
      httpUrl,
    );
    try {
      final respnese = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecrueToken": true,
          },
        ),
      );

      final respnseData=json.decode(respnese.body);
      if(respnseData["error"]!=null){
        throw HttpException(respnseData["error"]["message"]);
      }
    } catch (error) {

    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(
      email,
      password,
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAAYkIUxR_UXr89LP6pnRgCYyKj3wBXthc",
    );
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(
      email,
      password,
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAAYkIUxR_UXr89LP6pnRgCYyKj3wBXthc",
    );
  }
}
