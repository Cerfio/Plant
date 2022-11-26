import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_iot_epitech/models/plants.dart';
import 'package:plant_iot_epitech/providers/plant_provider.dart';
import 'package:plant_iot_epitech/screens/plant_elementary.dart';
import 'package:plant_iot_epitech/screens/plant_more_info.dart';
import 'package:plant_iot_epitech/screens/plant_nickname.dart';
import 'package:plant_iot_epitech/ui/cards/card_lengthen.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_age.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_battery.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_humidity_air.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_humidity_soil.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_light.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_pressure.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_temperature.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_water.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PlantDetail extends StatefulWidget {
  final String id;
  const PlantDetail({super.key, required this.id});

  @override
  State<PlantDetail> createState() => _PlantDetailState();
}

class _PlantDetailState extends State<PlantDetail> {
  final Widget tomatoPlant = SvgPicture.asset(
    'assets/plants/tomato_plant.svg',
    semanticsLabel: 'Palm leaf',
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    final plant = context.read<PlantProvider>();

    return FutureBuilder(
      future: plant.getPlant(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xffC9DBBD),
              child: SlidingUpPanel(
                parallaxEnabled: true,
                panelSnapping: true,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
                maxHeight: MediaQuery.of(context).size.height,
                minHeight: 520,
                panelBuilder: (ScrollController sc) => Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffF9FAF7),
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                  child: _scrollingList(sc, context, snapshot.data!.plant!),
                ),
                body: Center(
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Positioned(
                                left: 10,
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Color(0xff708265),
                                  ),
                                ),
                              ),
                              Text(
                                snapshot.data!.plant!.name,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff708265),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: tomatoPlant,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _scrollingList(
      ScrollController sc, BuildContext context, Plant plant) {
    void openCardElementary(int index, int maxY, String type) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PlantElementary(
            defaultChip: index,
            plantData: plant.datas,
            maxY: maxY,
            type: type,
          ),
        ),
      );
    }

    void redirectToPageNickname() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlantNickname(
            plantNickname: plant.name,
          ),
        ),
      );
    }

    void redirectTopPageMoreInfos() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlantMoreInfo(plant: plant)),
      );
    }

    return ListView(
      padding: const EdgeInsets.only(top: 35, bottom: 35),
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
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CardElementaryWater(
                  value: plant.datas[0].light,
                  callback: () => openCardElementary(0, 1024, 'humiditySoil'),
                ),
                const SizedBox(width: 20),
                CardElementaryTemperature(
                  value: plant.datas[0].temperature,
                  callback: () => openCardElementary(1, 100, 'temperature'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CardElementaryHumidityAir(
                  value: plant.datas[0].humidityAir,
                  callback: () => openCardElementary(2, 1024, 'humidityAir'),
                ),
                const SizedBox(width: 20),
                CardElementaryHumiditySoil(
                  value: plant.datas[0].humidityAir,
                  callback: () => openCardElementary(3, 1024, 'humiditySoil'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CardElementaryLight(
                  value: plant.datas[0].light,
                  callback: () => openCardElementary(4, 1024, 'light'),
                ),
                const SizedBox(width: 20),
                CardElementaryBattery(
                  value: plant.datas[0].battery,
                  callback: () => openCardElementary(5, 100, 'battery'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CardElementaryPressure(
                  value: plant.datas[0].pressure,
                  callback: () => openCardElementary(6, 1024, 'pressure'),
                ),
                const SizedBox(width: 20),
                CardElementaryAge(
                  callback: () => openCardElementary(7, 100, 'age'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              CardLengthen(
                title: "Nickname",
                subtitle: plant.name,
                callback: () => redirectToPageNickname(),
              ),
              const SizedBox(height: 20),
              CardLengthen(
                title: "More Informations",
                callback: () => redirectTopPageMoreInfos(),
              ),
              const SizedBox(height: 20),
              CardLengthen(
                title: "Plant Care",
                callback: () => redirectTopPageMoreInfos(),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => {
                  context.read<PlantProvider>().deletePlant(plant.id),
                  Navigator.pop(context),
                },
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
