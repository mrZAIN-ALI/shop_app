import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
//
import '../modals/httpDeleteProdException.dart';

class Auth with ChangeNotifier {
  String _token = "token";
  var _userId;
  DateTime? _expireDate;
  Timer? _authTimer;

  String get getUserId {
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
      autoSignOut();
      notifyListeners();
      final pref = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          "token": _token,
          "userId": _userId,
          "expireDate": _expireDate!.toIso8601String()
        },
      );
      pref.setString("userData", userData);

      _token = respnseData["idToken"];
      _userId = respnseData["localId"];
      _expireDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            respnseData["expiresIn"],
          ),
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
        _expireDate!.isAfter(DateTime.now()) &&
        _token != "token") {
      return _token;
    }
    return "No token avvailable";
  }

  void signOut() async{
    _userId = "";
    _expireDate = null;
    _token = "token";
    notifyListeners();
    final pref=await SharedPreferences.getInstance();
    pref.clear();
  }

  void autoSignOut() {
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    final time = _expireDate as DateTime;
    final timeToSignout = time.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToSignout), signOut);
  }

  Future<bool> autoSignin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey("userData")) {
      return false;
    }
    final String? userDataString = pref.getString("userData");
    if (userDataString == null) {
      return false;
    }
    final loadedUserData = json.decode(userDataString) as Map<String, dynamic>;
    final expDate=DateTime.parse(loadedUserData["expireDate"] as String);

    if(expDate.isAfter(DateTime.now())){
      return false;
    }
    _token=loadedUserData["token"] as String;
    _userId=loadedUserData["userId"] as String;
    _expireDate=loadedUserData["expireDate"] as DateTime;
    notifyListeners();
    autoSignOut();
    return true;
  }
}
