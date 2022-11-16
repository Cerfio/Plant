import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryTemperature extends StatelessWidget {
  const CardElementaryTemperature({
    super.key,
    required this.callback,
  });

  final Function callback;
  @override
  Widget build(BuildContext context) {
    return CardElementaryBase(
      backgroundColor: const Color(0xffF8EAEB),
      titleColor: const Color(0xffAC898B),
      subtitleColor: const Color(0xffAC898B),
      iconColor: const Color(0xffAC898B),
      title: 'Temperature',
      subtitle: '35°C',
      icon: Icons.thermostat_outlined,
      callback: callback,
    );
  }
}
