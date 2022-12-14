import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryLight extends StatelessWidget {
  final Function callback;
  final int value;

  const CardElementaryLight({
    super.key,
    required this.callback,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return CardElementaryBase(
      backgroundColor: const Color(0xffEEF8EA),
      titleColor: const Color(0xff89AC8C),
      subtitleColor: const Color(0xff89AC8C),
      iconColor: const Color(0xff89AC8C),
      title: 'Light',
      subtitle: '$value',
      icon: Icons.lightbulb_outline,
      callback: callback,
    );
  }
}
