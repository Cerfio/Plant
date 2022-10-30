import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryAge extends StatelessWidget {
  const CardElementaryAge({super.key});

  @override
  Widget build(BuildContext context) {
    return const CardElementaryBase(
      backgroundColor: Color(0xffFFD2D2),
      titleColor: Color(0xffBA6969),
      subtitleColor: Color(0xffBA6969),
      iconColor: Color(0xffBA6969),
      title: 'Age',
      subtitle: 'Seedling',
      icon: Icons.hourglass_bottom_outlined,
    );
  }
}
