import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryBattery extends StatelessWidget {
  const CardElementaryBattery({super.key});

  @override
  Widget build(BuildContext context) {
    return const CardElementaryBase(
      backgroundColor: Color(0xffF8F8EA),
      titleColor: Color(0xffACAC68),
      subtitleColor: Color(0xffACAC68),
      iconColor: Color(0xffACAC68),
      title: 'Battery',
      subtitle: '42%',
      icon: Icons.battery_full_outlined,
    );
  }
}
