import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plant_iot_epitech/models/plants.dart';
import 'package:plant_iot_epitech/services/api_url.dart';
import 'package:plant_iot_epitech/storage/user_preferences.dart';

enum CreatePlantStatus {
  notCreated,
  creating,
  created,
}

enum GetPlantsStatus {
  notFetched,
  fetching,
  fetched,
}

enum GetPlantStatus {
  notFetched,
  fetching,
  fetched,
}

enum DeletePlantStatus {
  notDeleted,
  deleting,
  deleted,
}

class PlantsOutput {
  final bool status;
  final String? error;
  final String? message;
  List<Plants>? plants = [];

  PlantsOutput({
    required this.status,
    this.error,
    this.message,
    this.plants,
  });
}

class PlantProvider with ChangeNotifier {
  CreatePlantStatus _createPlantStatus = CreatePlantStatus.notCreated;
  GetPlantsStatus _getPlantsStatus = GetPlantsStatus.notFetched;
  GetPlantStatus _getPlantStatus = GetPlantStatus.notFetched;
  DeletePlantStatus _deletePlantStatus = DeletePlantStatus.notDeleted;

  CreatePlantStatus get createPlantStatus => _createPlantStatus;
  GetPlantsStatus get getPlantsStatus => _getPlantsStatus;
  DeletePlantStatus get deletePlantStatus => _deletePlantStatus;

  Future<PlantsOutput> createPlant(
      String macAddress, String serialNumber) async {
    String token = await UserPreferences().getUserToken();
    if (token == "") {
      return PlantsOutput(
        status: false,
        error: "No token",
        message: "No token",
      );
    }

    Map<String, dynamic> createPlantData = {
      'macAddress': macAddress,
      'serialNumber': serialNumber,
    };

    _createPlantStatus = CreatePlantStatus.creating;
    notifyListeners();

    Response response = await post(
      Uri.parse(ApiURL.plant),
      body: json.encode(createPlantData),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      _createPlantStatus = CreatePlantStatus.created;
      notifyListeners();
      return PlantsOutput(
        status: true,
        message: responseData['message'],
      );
    }

    _createPlantStatus = CreatePlantStatus.notCreated;
    notifyListeners();
    return PlantsOutput(
      status: false,
      error: responseData['error'],
      message: responseData['message'],
    );
  }

  Future<PlantsOutput> getPlants() async {
    String token = await UserPreferences().getUserToken();
    if (token == "") {
      return PlantsOutput(
        status: false,
        error: "No token",
        message: "No token",
      );
    }

    _getPlantsStatus = GetPlantsStatus.fetching;
    notifyListeners();

    Response response = await get(
      Uri.parse(ApiURL.plant),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    List<Plants> plants = plantsFromJson(response.body);

    if (response.statusCode == 200) {
      _getPlantsStatus = GetPlantsStatus.fetched;
      notifyListeners();
      return PlantsOutput(
        status: true,
        message: "Plants fetched",
        plants: plants,
      );
    }

    Map<String, dynamic> responseData = json.decode(response.body);
    _getPlantsStatus = GetPlantsStatus.notFetched;
    notifyListeners();
    return PlantsOutput(
      status: false,
      error: responseData['error'],
      message: responseData['message'],
    );
  }

  Future<PlantsOutput> getPlant() async {
    String token = await UserPreferences().getUserToken();
    if (token == "") {
      return PlantsOutput(
        status: false,
        error: "No token",
        message: "No token",
      );
    }

    _getPlantStatus = GetPlantStatus.fetching;
    notifyListeners();

    Response response = await get(
      Uri.parse(ApiURL.plant),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    List<Plants> plants = plantsFromJson(response.body);

    if (response.statusCode == 200) {
      _getPlantStatus = GetPlantStatus.fetched;
      notifyListeners();
      return PlantsOutput(
        status: true,
        message: "Plants fetched",
        plants: plants,
      );
    }

    Map<String, dynamic> responseData = json.decode(response.body);
    _getPlantStatus = GetPlantStatus.notFetched;

    notifyListeners();
    return PlantsOutput(
      status: false,
      error: responseData['error'],
      message: responseData['message'],
    );
  }
}
