import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryHumidityAir extends StatelessWidget {
  final Function callback;
  final int value;

  const CardElementaryHumidityAir({
    super.key,
    required this.callback,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return CardElementaryBase(
      backgroundColor: const Color(0xffFFF4D2),
      titleColor: const Color(0xffB9AA70),
      subtitleColor: const Color(0xffB9AA70),
      iconColor: const Color(0xffB9AA70),
      title: 'Humidity Air',
      subtitle: '$value',
      icon: Icons.air_outlined,
      callback: callback,
    );
  }
}
