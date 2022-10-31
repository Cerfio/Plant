// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart';

class PlantElementary extends StatelessWidget {
  PlantElementary({super.key});
  //Don't forgert to move to another file
  final Widget waterIcon = SvgPicture.asset('assets/elementaries/water.svg',
      semanticsLabel: 'Palm leaf', fit: BoxFit.cover);

  // "Water Quantity",
  // "Temperature",
  // "Humidity Air",
  // "Humidity Soil",
  // "Light",
  // "Battery",
  // "Age",
  // "Pressure",
  final list = [
    {
      "title": "Water Quantity",
      "color": const Color(0xff4375AB),
      "backgroundColor": const Color(0xffEDF7FF),
      "icon": Icons.water_drop_outlined,
    },
    {
      "title": "Temperature",
      "color": const Color(0xffF9A826),
      "backgroundColor": const Color(0xffFFF7E6),
      "icon": Icons.thermostat_outlined,
    },
    {
      "title": "Humidity Air",
      "color": const Color(0xffF9A826),
      "backgroundColor": const Color(0xffFFF7E6),
      "icon": Icons.thermostat_outlined,
    },
    {
      "title": "Humidity Soil",
      "color": const Color(0xffF9A826),
      "backgroundColor": const Color(0xffFFF7E6),
      "icon": Icons.thermostat_outlined,
    },
    {
      "title": "Light",
      "color": const Color(0xffF9A826),
      "backgroundColor": const Color(0xffFFF7E6),
      "icon": Icons.thermostat_outlined,
    },
    {
      "title": "Battery",
      "color": const Color(0xffF9A826),
      "backgroundColor": const Color(0xffFFF7E6),
      "icon": Icons.thermostat_outlined,
    },
    {
      "title": "Age",
      "color": const Color(0xffF9A826),
      "backgroundColor": const Color(0xffFFF7E6),
      "icon": Icons.thermostat_outlined,
    },
    {
      "title": "Pressure",
      "color": const Color(0xffF9A826),
      "backgroundColor": const Color(0xffFFF7E6),
      "icon": Icons.thermostat_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF9FAF7),
        title: const Text('Water Quantity',
            style: TextStyle(color: Color(0xff2263A8))),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Card(
                  elevation: 0,
                  color: const Color(0xffEDF7FF),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Icon(Icons.water_drop_outlined,
                              size: 128, color: Color(0xff2263A8)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 32, top: 32),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                for (final item in list)
                  Row(
                    children: const [
                      Chip(
                        padding: EdgeInsets.all(5),
                        backgroundColor: Color(0xffEDF7FF),
                        label: Text("item",
                            style: TextStyle(color: Color(0xff4375AB))),
                      ),
                      SizedBox(width: 12),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
