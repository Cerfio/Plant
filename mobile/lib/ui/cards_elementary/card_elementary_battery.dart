import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_base.dart';

class CardElementaryBattery extends StatelessWidget {
  final Function callback;
  final int value;

  const CardElementaryBattery({
    super.key,
    required this.callback,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return CardElementaryBase(
      backgroundColor: const Color(0xffF8F8EA),
      titleColor: const Color(0xffACAC68),
      subtitleColor: const Color(0xffACAC68),
      iconColor: const Color(0xffACAC68),
      title: 'Battery',
      subtitle: '$value%',
      icon: Icons.battery_full_outlined,
      callback: callback,
    );
  }
}
