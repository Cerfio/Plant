import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryPressure extends StatelessWidget {
  const CardElementaryPressure({
    super.key,
    required this.callback,
  });

  final Function callback;
  @override
  Widget build(BuildContext context) {
    return CardElementaryBase(
      backgroundColor: const Color(0xffEAEDF8),
      titleColor: const Color(0xff8C89AC),
      subtitleColor: const Color(0xff8C89AC),
      iconColor: const Color(0xff8C89AC),
      title: 'Pressure',
      subtitle: '1004.53 hPa',
      icon: Icons.landscape_outlined,
      callback: callback,
    );
  }
}
