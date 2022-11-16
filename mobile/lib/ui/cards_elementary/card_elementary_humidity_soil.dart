import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryHumiditySoil extends StatelessWidget {
  const CardElementaryHumiditySoil({
    super.key,
    required this.callback,
  });

  final Function callback;
  @override
  Widget build(BuildContext context) {
    return CardElementaryBase(
      backgroundColor: const Color(0xffF9D2FF),
      titleColor: const Color(0xffB870B9),
      subtitleColor: const Color(0xffB870B9),
      iconColor: const Color(0xffB870B9),
      title: 'Humidity Soil',
      subtitle: 'Dry',
      icon: Icons.layers_outlined,
      callback: callback,
    );
  }
}
