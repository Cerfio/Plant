import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryPressure extends StatelessWidget {
  const CardElementaryPressure({super.key});

  @override
  Widget build(BuildContext context) {
    return const CardElementaryBase(
      backgroundColor: Color(0xffEAEDF8),
      titleColor: Color(0xff8C89AC),
      subtitleColor: Color(0xff8C89AC),
      iconColor: Color(0xff8C89AC),
      title: 'Pressure',
      subtitle: '1004.53 hPa',
      icon: Icons.landscape_outlined,
    );
  }
}
