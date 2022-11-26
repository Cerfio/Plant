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
  List<Plant>? plants = [];
  Plant? plant;

  PlantsOutput({
    required this.status,
    this.error,
    this.message,
    this.plants,
    this.plant,
  });
}

class PlantProvider with ChangeNotifier {
  CreatePlantStatus _createPlantStatus = CreatePlantStatus.notCreated;
  GetPlantsStatus _getPlantsStatus = GetPlantsStatus.notFetched;
  GetPlantStatus _getPlantStatus = GetPlantStatus.notFetched;
  DeletePlantStatus _deletePlantStatus = DeletePlantStatus.notDeleted;

  CreatePlantStatus get createPlantStatus => _createPlantStatus;
  GetPlantsStatus get getPlantsStatus => _getPlantsStatus;
  GetPlantStatus get getPlantStatus => _getPlantStatus;
  DeletePlantStatus get deletePlantStatus => _deletePlantStatus;

  Future<PlantsOutput> createPlant(String serialNumber) async {
    String token = await UserPreferences().getUserToken();
    if (token == "") {
      return PlantsOutput(
        status: false,
        error: "No token",
        message: "No token",
      );
    }

    Map<String, dynamic> createPlantData = {
      'macAddress': '00:1B:44:11:3A:B7',
      'serialNumber': serialNumber,
    };

    _createPlantStatus = CreatePlantStatus.creating;

    Response response = await post(
      Uri.parse(ApiURL.plant),
      body: json.encode(createPlantData),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    Plant plant = Plant.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      _createPlantStatus = CreatePlantStatus.created;
      notifyListeners();
      return PlantsOutput(
        status: true,
        message: "Plant Added",
        plant: plant,
      );
    }

    Map<String, dynamic> responseData = json.decode(response.body);
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

    Response response = await get(
      Uri.parse(ApiURL.plant),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    List<Plant> plants = plantFromJson(response.body);

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

  Future<PlantsOutput> getPlant(String id) async {
    String token = await UserPreferences().getUserToken();
    if (token == "") {
      return PlantsOutput(
        status: false,
        error: "No token",
        message: "No token",
      );
    }

    _getPlantStatus = GetPlantStatus.fetching;

    Response response = await get(
      Uri.parse('${ApiURL.plant}/$id'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    Plant plant = Plant.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      _getPlantStatus = GetPlantStatus.fetched;
      notifyListeners();
      return PlantsOutput(
        status: true,
        message: "Plant fetched",
        plant: plant,
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

  Future<PlantsOutput> deletePlant(String id) async {
    String token = await UserPreferences().getUserToken();
    if (token == "") {
      return PlantsOutput(
        status: false,
        error: "No token",
        message: "No token",
      );
    }
    _getPlantStatus = GetPlantStatus.fetching;

    Response response = await delete(
      Uri.parse('${ApiURL.plant}/$id'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      _deletePlantStatus = DeletePlantStatus.deleted;
      notifyListeners();
      return PlantsOutput(
        status: true,
        message: "Plant deleted !",
      );
    }
    return PlantsOutput(
      status: false,
      error: responseData['error'],
      message: responseData['message'],
    );
  }
}
