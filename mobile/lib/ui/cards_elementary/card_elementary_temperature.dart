import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryTemperature extends StatelessWidget {
  const CardElementaryTemperature({super.key});

  @override
  Widget build(BuildContext context) {
    return const CardElementaryBase(
      backgroundColor: Color(0xffF8EAEB),
      titleColor: Color(0xffAC898B),
      subtitleColor: Color(0xffAC898B),
      iconColor: Color(0xffAC898B),
      title: 'Temperature',
      subtitle: '35°C',
      icon: Icons.thermostat_outlined,
    );
  }
}
