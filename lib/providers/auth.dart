// ignore_for_file: avoid_print, use_rethrow_when_possible, unused_field

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exceptions.dart';

class Auth extends ChangeNotifier {
  String? _tocken;
  DateTime? _expireDate;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expireDate != null &&
        _expireDate!.isAfter(DateTime.now()) &&
        _tocken != null)
      // ignore: curly_braces_in_flow_control_structures
      return _tocken!;
    return null;
  }

  ///SignUp of creating account///
  Future<void> signUP(String userName, String email, String password) async {
    final url = Uri.https(
        'identitytoolkit.googleapis.com',
        '/v1/accounts:signUp',
        {'key': 'AIzaSyCVI5MJFsWMiYK3JwR2WiVEDkO19XUed1k'});
    try {
      final response = await http.post(url,
          body: json.encode({
            'userName': userName,
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      print(json.decode(response.body));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ///Login with email and password///
  Future<void> login(String email, String password) async {
    final url = Uri.https(
        'identitytoolkit.googleapis.com',
        '/v1/accounts:signInWithPassword',
        {'key': 'AIzaSyCVI5MJFsWMiYK3JwR2WiVEDkO19XUed1k'});
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpExceptions(responseData['error']['message']);
      }
      _tocken = responseData['idToken'];
      _userId = responseData['localId'];
      _expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
