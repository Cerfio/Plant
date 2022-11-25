import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/screens/plant.dart';
import 'package:plant_iot_epitech/ui/bars/icon_progress_bar.dart';

class PlantStatus extends StatelessWidget {
  final String name;
  final String type;
  final double waterStatus;
  final double lightStatus;
  final double temperatureStatus;

  const PlantStatus({
    super.key,
    required this.name,
    required this.type,
    required this.waterStatus,
    required this.lightStatus,
    required this.temperatureStatus,
  });

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
              value: waterStatus,
            ),
            const SizedBox(height: 8),
            IconProgressBar(
              iconName: 'sun',
              value: lightStatus,
            ),
            const SizedBox(height: 8),
            IconProgressBar(
              iconName: 'thermometer',
              value: temperatureStatus,
            ),
          ],
        ),
      ),
    );
  }
}
