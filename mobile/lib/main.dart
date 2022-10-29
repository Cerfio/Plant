import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/pages/plant.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_humidity_air.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_humidity_soil.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_light.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_pressure.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_temperature.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_water.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Plant(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 32),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco_outlined, size: 32),
            label: 'My plants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined, size: 32),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, size: 32),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff8BA07E),
        onTap: _onItemTapped,
      ),
    );
  }
}
