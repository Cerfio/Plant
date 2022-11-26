import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryTemperature extends StatelessWidget {
  final Function callback;
  final int value;

  const CardElementaryTemperature({
    super.key,
    required this.callback,
    required this.value,
  });


  @override
  Widget build(BuildContext context) {
    return CardElementaryBase(
      backgroundColor: const Color(0xffF8EAEB),
      titleColor: const Color(0xffAC898B),
      subtitleColor: const Color(0xffAC898B),
      iconColor: const Color(0xffAC898B),
      title: 'Temperature',
      subtitle: '$value °C',
      icon: Icons.thermostat_outlined,
      callback: callback,
    );
  }
}
