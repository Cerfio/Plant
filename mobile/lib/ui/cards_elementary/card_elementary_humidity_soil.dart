import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryHumiditySoil extends StatelessWidget {
  const CardElementaryHumiditySoil({super.key});

  @override
  Widget build(BuildContext context) {
    return const CardElementaryBase(
      backgroundColor: Color(0xffF9D2FF),
      titleColor: Color(0xffB870B9),
      subtitleColor: Color(0xffB870B9),
      iconColor: Color(0xffB870B9),
      title: 'Humidity Soil',
      subtitle: 'Dry',
      icon: Icons.layers_outlined,
    );
  }
}
