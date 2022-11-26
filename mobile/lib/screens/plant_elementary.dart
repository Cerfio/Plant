import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_iot_epitech/models/plants.dart';
import 'package:plant_iot_epitech/ui/charts/chart.dart';

class PlantElementary extends StatefulWidget {
  final int defaultChip;
  final List<PlantData> plantData;
  final int maxY;
  final String type;

  const PlantElementary({
    super.key,
    required this.defaultChip,
    required this.plantData,
    required this.maxY,
    required this.type,
  });

  @override
  State<PlantElementary> createState() => _PlantElementaryState();
}

class _PlantElementaryState extends State<PlantElementary> {
  //Don't forgert to move to another file
  final Widget waterIcon = SvgPicture.asset(
    'assets/elementaries/water.svg',
    semanticsLabel: 'Palm leaf',
    fit: BoxFit.cover,
  );

  int currentChip = 0;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    currentChip = widget.defaultChip;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.animateTo(
        list[currentChip]["move"] as double,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  final list = [
    {
      "title": "Water Quantity",
      "color": const Color(0xff4375AB),
      "backgroundColor": const Color(0xffEDF7FF),
      "icon": Icons.water_drop_outlined,
      "move": 20.0,
    },
    {
      "title": "Temperature",
      "color": const Color(0xffAC898B),
      "backgroundColor": const Color(0xffF8EAEB),
      "icon": Icons.thermostat_outlined,
      "move": 180.0,
    },
    {
      "title": "Humidity Air",
      "color": const Color(0xffB9AA70),
      "backgroundColor": const Color(0xffFFF4D2),
      "icon": Icons.air_outlined,
      "move": 320.0,
    },
    {
      "title": "Humidity Soil",
      "color": const Color(0xffB870B9),
      "backgroundColor": const Color(0xffF9D2FF),
      "icon": Icons.layers_outlined,
      "move": 472.0,
    },
    {
      "title": "Light",
      "color": const Color(0xff89AC8C),
      "backgroundColor": const Color(0xffEEF8EA),
      "icon": Icons.lightbulb_outline,
      "move": 600.0,
    },
    {
      "title": "Battery",
      "color": const Color(0xffACAC68),
      "backgroundColor": const Color(0xffF8F8EA),
      "icon": Icons.battery_full_outlined,
      "move": 600.0,
    },
    {
      "title": "Pressure",
      "color": const Color(0xff8C89AC),
      "backgroundColor": const Color(0xffEAEDF8),
      "icon": Icons.landscape_outlined,
      "move": 600.0,
    },
    {
      "title": "Age",
      "color": const Color(0xffBA6969),
      "backgroundColor": const Color(0xffFFD2D2),
      "icon": Icons.hourglass_bottom_outlined,
      "move": 600.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF9FAF7),
        title: Text(list[currentChip]["title"] as String,
            style: TextStyle(color: list[currentChip]["color"] as Color)),
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
                  color: list[currentChip]["backgroundColor"] as Color,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(
                              list[currentChip]["icon"] as IconData,
                              size: 128,
                              color: list[currentChip]["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            controller: _controller,
            padding: const EdgeInsets.only(left: 32, top: 32),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: [
                    for (var i = 0; i < list.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () => {
                            setState(() {
                              currentChip = i;
                            }),
                          },
                          child: Chip(
                            padding: const EdgeInsets.all(12),
                            backgroundColor: i == currentChip
                                ? list[i]['backgroundColor'] as Color
                                : const Color(0xffF2F4F5),
                            label: Text(
                              list[i]["title"] as String,
                              style: TextStyle(
                                color: i == currentChip
                                    ? list[i]['color'] as Color
                                    : const Color(0xff757575),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: LineChartSample2(
              plantData: widget.plantData,
              maxY: widget.maxY,
              type: widget.type,
            ),
          ),
        ],
      ),
    );
  }
}
