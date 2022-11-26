import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/screens/plant.dart';
import 'package:plant_iot_epitech/ui/bars/icon_progress_bar.dart';

class PlantStatus extends StatelessWidget {
  final String id;
  final String name;
  final String type;
  final int waterStatus;
  final int lightStatus;
  final int temperatureStatus;

  const PlantStatus({
    super.key,
    required this.id,
    required this.name,
    required this.type,
    required this.waterStatus,
    required this.lightStatus,
    required this.temperatureStatus,
  });

  double convertTemperatureStatus() {
    if (temperatureStatus >= 30) {
      return 1.0;
    } else if (temperatureStatus < 30 && temperatureStatus >= 20) {
      return 0.66;
    } else if (temperatureStatus < 20 && temperatureStatus >= 10) {
      return 0.33;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Plant();
            },
          ),
        )
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff8BA07E),
              ),
            ),
            SizedBox(
              width: 72,
              height: 72,
              child: Image.asset('assets/plants/plant-$type.png'),
            ),
            const SizedBox(height: 8),
            IconProgressBar(
              iconName: 'water-droplet',
              value: waterStatus * 100 / 1024 / 100,
            ),
            const SizedBox(height: 8),
            IconProgressBar(
              iconName: 'sun',
              value: lightStatus * 100 / 1024 / 100,
            ),
            const SizedBox(height: 8),
            IconProgressBar(
              iconName: 'thermometer',
              value: convertTemperatureStatus(),
            ),
          ],
        ),
      ),
    );
  }
}
