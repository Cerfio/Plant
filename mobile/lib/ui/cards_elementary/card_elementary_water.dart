import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryWater extends StatelessWidget {
  const CardElementaryWater({
    super.key,
    required this.callback,
  });

  final Function callback;
  @override
  Widget build(BuildContext context) {
    return CardElementaryBase(
      backgroundColor: const Color(0xffEDF7FF),
      titleColor: const Color(0xff4375AB),
      subtitleColor: const Color(0xff4375AB),
      iconColor: const Color(0xff4375AB),
      title: 'Water Quantity',
      subtitle: 'Give Water',
      icon: Icons.water_drop_outlined,
      callback: callback,
    );
  }
}
