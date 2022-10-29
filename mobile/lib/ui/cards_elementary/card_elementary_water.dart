import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryWater extends StatelessWidget {
  const CardElementaryWater({super.key});

  @override
  Widget build(BuildContext context) {
    return const CardElementaryBase(
      backgroundColor: Color(0xffEDF7FF),
      titleColor: Color(0xff4375AB),
      subtitleColor: Color(0xff4375AB),
      iconColor: Color(0xff4375AB),
      title: 'Water Quantity',
      subtitle: 'Give Water',
      icon: Icons.water_drop_outlined,
    );
  }
}
