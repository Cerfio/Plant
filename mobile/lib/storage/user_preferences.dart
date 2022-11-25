import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plant_iot_epitech/models/user.dart';

class UserPreferences {
  Future<bool> getUserFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('userFirstTime') ?? true;
  }

  Future<void> setUserFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('userFirstTime', true);
  }

  Future<void> setUserToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  Future<String> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? "";
  }

  Future<void> removeUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }

  Future<void> setUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", user.userId);
    prefs.setString("firstName", user.firstName);
    prefs.setString("lastName", user.lastName);
    prefs.setString("email", user.email);
    prefs.setString("token", user.token);
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString("userId") ?? "";
    String firstName = prefs.getString("firstName") ?? "";
    String lastName = prefs.getString("lastName") ?? "";
    String email = prefs.getString("email") ?? "";
    String token = prefs.getString("token") ?? "";

    return User(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      token: token,
    );
  }

  Future<void> deleteUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userId");
    prefs.remove("firstName");
    prefs.remove("lastName");
    prefs.remove("email");
    prefs.remove("token");
  }
}
