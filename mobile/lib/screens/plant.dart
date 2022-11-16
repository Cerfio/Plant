import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_iot_epitech/screens/plant_elementary.dart';
import 'package:plant_iot_epitech/ui/cards/card_lengthen.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_age.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_battery.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_humidity_air.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_humidity_soil.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_light.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_pressure.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_temperature.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_water.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Plant extends StatelessWidget {
  Plant({super.key});
  //Don't forgert to move to another file
  final Widget tomatoPlant = SvgPicture.asset('assets/plants/tomato_plant.svg',
      semanticsLabel: 'Palm leaf', fit: BoxFit.cover);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xffC9DBBD),
      child: SlidingUpPanel(
        parallaxEnabled: true,
        panelSnapping: true,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45), topRight: Radius.circular(45)),
        maxHeight: MediaQuery.of(context).size.height - 10,
        minHeight: 520,
        panelBuilder: (ScrollController sc) => Container(
            decoration: const BoxDecoration(
              color: Color(0xffF9FAF7),
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            child: _scrollingList(sc, context)),
        body: Center(
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text("Aznard",
                        style: TextStyle(fontSize: 32),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: tomatoPlant,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _scrollingList(ScrollController sc, BuildContext context) {
    void openCardElementary(int index) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PlantElementary(defaultChip: index),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.only(top: 35, bottom: 130),
      controller: sc,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 8,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(12.0))),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          "Care recommendations",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xff8BA07E),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Row(
            children: [
              const SizedBox(width: 20),
              CardElementaryWater(callback: () => openCardElementary(0)),
              const SizedBox(width: 20),
              CardElementaryTemperature(callback: () => openCardElementary(1)),
              const SizedBox(width: 20),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Row(
            children: [
              const SizedBox(width: 20),
              CardElementaryHumidityAir(callback: () => openCardElementary(2)),
              const SizedBox(width: 20),
              CardElementaryHumiditySoil(callback: () => openCardElementary(3)),
              const SizedBox(width: 20),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Row(
            children: [
              const SizedBox(width: 20),
              CardElementaryLight(callback: () => openCardElementary(4)),
              const SizedBox(width: 20),
              CardElementaryBattery(callback: () => openCardElementary(5)),
              const SizedBox(width: 20),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Row(
            children: [
              const SizedBox(width: 20),
              CardElementaryPressure(callback: () => openCardElementary(6)),
              const SizedBox(width: 20),
              CardElementaryAge(callback: () => openCardElementary(7)),
              const SizedBox(width: 20),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Plant Parameter",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff8BA07E),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const CardLengthen(title: "Nickname", subtitle: "Aznard"),
              const SizedBox(height: 20),
              const CardLengthen(title: "More Informations"),
              const SizedBox(height: 20),
              const CardLengthen(title: "Plant Care"),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Unlink Plant",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff980A0A),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
