import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryPressure extends StatelessWidget {
  final Function callback;
  final int value;

  const CardElementaryPressure({
    super.key,
    required this.callback,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return CardElementaryBase(
      backgroundColor: const Color(0xffEAEDF8),
      titleColor: const Color(0xff8C89AC),
      subtitleColor: const Color(0xff8C89AC),
      iconColor: const Color(0xff8C89AC),
      title: 'Pressure',
      subtitle: '$value hPa',
      icon: Icons.landscape_outlined,
      callback: callback,
    );
  }
}
