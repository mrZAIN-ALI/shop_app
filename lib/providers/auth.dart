import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier{

  late String _token;
  late String _userId;
  late String _expireDate;

  Future<void> signUp(String email ,String password)async{

    final url = Uri.parse(
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAAYkIUxR_UXr89LP6pnRgCYyKj3wBXthc",
    );
    final respnese = await http.post(url,body: json.encode({
      "email": email,
      "password": password,
      "returnSecrueToken": true,
    },),);

    print(json.encode(respnese.body),);
  }

}