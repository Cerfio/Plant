import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryLight extends StatelessWidget {
  const CardElementaryLight({super.key});

  @override
  Widget build(BuildContext context) {
    return const CardElementaryBase(
      backgroundColor: Color(0xffEEF8EA),
      titleColor: Color(0xff89AC8C),
      subtitleColor: Color(0xff89AC8C),
      iconColor: Color(0xff89AC8C),
      title: 'Light',
      subtitle: 'Very Bright',
      icon: Icons.water_drop_outlined,
    );
  }
}
