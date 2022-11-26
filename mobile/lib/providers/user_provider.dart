import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plant_iot_epitech/models/user.dart';
import 'package:plant_iot_epitech/services/api_url.dart';
import 'package:plant_iot_epitech/storage/user_preferences.dart';

enum GetUserStatus {
  notFetched,
  fetching,
  fetched,
}

class UserOutput {
  final bool status;
  final String? error;
  final String? message;
  final User? user;

  UserOutput({
    required this.status,
    this.error,
    this.message,
    this.user,
  });
}

class UserProvider with ChangeNotifier {
  GetUserStatus _getUserStatus = GetUserStatus.notFetched;
  GetUserStatus get getUserStatus => _getUserStatus;

  // Get user from API
  Future<UserOutput> getUser() async {
    String token = await UserPreferences().getUserToken();
    if (token == "") {
      UserOutput(
        status: false,
        error: "No token",
        message: "No token",
      );
    }

    _getUserStatus = GetUserStatus.fetching;

    Response response = await get(
      Uri.parse(ApiURL.getUser),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    Map<String, dynamic> responseData = json.decode(response.body);

    print(responseData);

    if (response.statusCode == 200) {
      User user = User.fromJson(responseData);
      _getUserStatus = GetUserStatus.fetched;
      notifyListeners();

      return UserOutput(
        status: true,
        message: "User fetched",
        user: user,
      );
    }
    return UserOutput(
      status: false,
      error: responseData['error'],
      message: responseData['message'],
    );
  }
}
