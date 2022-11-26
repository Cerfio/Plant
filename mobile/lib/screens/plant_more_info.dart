import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/models/plants.dart';
import 'package:plant_iot_epitech/ui/cards/card_lengthen.dart';

class PlantMoreInfo extends StatelessWidget {
  final Plant plant;

  const PlantMoreInfo({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF9FAF7),
        elevation: 0,
        title: Text(
          plant.name,
          style: const TextStyle(
            color: Color(0xff293B1C),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "More Informations",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              CardLengthen(
                title: "Model",
                subtitle: "Plant one",
                callback: () => {},
                displayChevron: false,
              ),
              const SizedBox(height: 40),
              CardLengthen(
                title: "Mac Adress",
                subtitle: plant.macAddress,
                callback: () => {},
                displayChevron: false,
              ),
              const SizedBox(height: 40),
              CardLengthen(
                title: "Serial Number",
                subtitle: plant.serialNumber,
                callback: () => {},
                displayChevron: false,
              ),
              const SizedBox(height: 40),
              CardLengthen(
                title: "Firmware",
                subtitle: "v4.15.0",
                callback: () => {},
                displayChevron: false,
              ),
              const SizedBox(height: 40),
              CardLengthen(
                title: "Activation Date",
                subtitle: "2022-09-16",
                callback: () => {},
                displayChevron: false,
              ),
              const SizedBox(height: 40),
              CardLengthen(
                title: "Number of alert",
                subtitle: "94",
                callback: () => {},
                displayChevron: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
