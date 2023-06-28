import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//
import '../modals/httpDeleteProdException.dart';

class Auth with ChangeNotifier {
  String _token="token";
  var _userId;
  var _expireDate;

  String get getUserId{
    return _userId;
  }
  void setTkn(String tok) {
    _token = tok;
    // print(_token);
  }

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
            "returnSecureToken": true,
          },
        ),
      );

      final respnseData = json.decode(respnese.body);
      // print(respnseData["expiresIn"]);
      if (respnseData["error"] != null) {
        throw HttpException(respnseData["error"]["message"]);
      }
      String temp = respnseData["idToken"];
      setTkn(temp);
      _userId = respnseData["localId"];
      _expireDate = DateTime.now().add(
        Duration(
          seconds: int.parse(respnseData["expiresIn"]),
        ),
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
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

  bool get isAuthenticated {
    return _token != "token";
  }

  String get getToken {
    if (_expireDate != null &&
        _expireDate.isAfter(DateTime.now()) &&
        _token != "token") {
      return _token;
    }
    return "No token avvailable";
  }
}
