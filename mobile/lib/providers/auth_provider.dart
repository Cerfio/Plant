import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plant_iot_epitech/services/api_url.dart';
import 'package:plant_iot_epitech/storage/user_preferences.dart';

enum Status {
  notLoggedIn,
  authenticating,
  loggedIn,
  notRegistered,
  registering,
  registered,
  loggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.notLoggedIn;
  Status _registeredInStatus = Status.notRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> signUp(
      String email, String firstName, String lastName, String password) async {
    Map<String, dynamic> signUpData = {
      'email': email,
      'firstname': firstName,
      'lastname': lastName,
      'password': password,
    };

    _registeredInStatus = Status.registering;
    notifyListeners();

    Response response = await post(
      Uri.parse(ApiURL.signUp),
      body: json.encode(signUpData),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );

    Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      _registeredInStatus = Status.registered;
      notifyListeners();
      return {
        'status': true,
        'error': null,
        'message': 'User registered successfully'
      };
    }
    _registeredInStatus = Status.notRegistered;
    notifyListeners();
    return {
      'status': false,
      'error': responseData['error'],
      'message': responseData['message']
    };
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    Map<String, dynamic> signInData = {
      'email': email,
      'password': password,
    };

    _loggedInStatus = Status.authenticating;
    notifyListeners();

    Response response = await post(
      Uri.parse(ApiURL.signIn),
      body: json.encode(signInData),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );

    Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      _registeredInStatus = Status.loggedIn;
      UserPreferences().setUserToken(responseData['message']);
      notifyListeners();
      return {
        'status': true,
        'error': null,
        'message': 'User login successfully'
      };
    }
    _registeredInStatus = Status.notLoggedIn;
    notifyListeners();
    return {
      'status': false,
      'error': responseData['error'],
      'message': responseData['message']
    };
  }
}
