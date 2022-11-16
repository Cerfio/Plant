import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryAge extends StatelessWidget {
  const CardElementaryAge({
    super.key,
    required this.callback,
  });

  final Function callback;
  @override
  Widget build(BuildContext context) {
    return CardElementaryBase(
      backgroundColor: const Color(0xffFFD2D2),
      titleColor: const Color(0xffBA6969),
      subtitleColor: const Color(0xffBA6969),
      iconColor: const Color(0xffBA6969),
      title: 'Age',
      subtitle: 'Seedling',
      icon: Icons.hourglass_bottom_outlined,
      callback: callback,
    );
  }
}
