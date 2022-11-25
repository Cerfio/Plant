import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards/plant_status.dart';

class MyPlants extends StatelessWidget {
  const MyPlants({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color(0xffF9FAF7),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'My plants',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff708265),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: (MediaQuery.of(context).size.width / 2 / 280),
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 12,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: const <Widget>[
                    PlantStatus(
                      name: 'Tomato',
                      type: '1',
                      waterStatus: 0.33,
                      lightStatus: 0.66,
                      temperatureStatus: 1,
                    ),
                    PlantStatus(
                      name: 'Persil',
                      type: '2',
                      waterStatus: 0.66,
                      lightStatus: 0.67,
                      temperatureStatus: 1,
                    ),
                    PlantStatus(
                      name: 'Strawberry',
                      type: '3',
                      waterStatus: 0.99,
                      lightStatus: 0.67,
                      temperatureStatus: 1,
                    ),
                    PlantStatus(
                      name: 'Sunflower',
                      type: '4',
                      waterStatus: 0.99,
                      lightStatus: 0.67,
                      temperatureStatus: 1,
                    ),
                    PlantStatus(
                      name: 'Sunflower',
                      type: '4',
                      waterStatus: 0.99,
                      lightStatus: 0.67,
                      temperatureStatus: 1,
                    ),
                    PlantStatus(
                      name: 'Sunflower',
                      type: '4',
                      waterStatus: 0.99,
                      lightStatus: 0.67,
                      temperatureStatus: 1,
                    ),
                    PlantStatus(
                      name: 'Sunflower',
                      type: '4',
                      waterStatus: 0.99,
                      lightStatus: 0.67,
                      temperatureStatus: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
