import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryHumidityAir extends StatelessWidget {
  const CardElementaryHumidityAir({super.key});

  @override
  Widget build(BuildContext context) {
    return const CardElementaryBase(
      backgroundColor: Color(0xffFFF4D2),
      titleColor: Color(0xffB9AA70),
      subtitleColor: Color(0xffB9AA70),
      iconColor: Color(0xffB9AA70),
      title: 'Humidity Air',
      subtitle: 'Dry',
      icon: Icons.air_outlined,
    );
  }
}
