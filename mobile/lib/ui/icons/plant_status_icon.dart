import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlantStatusIcon extends StatelessWidget {
  final String iconName;
  const PlantStatusIcon({super.key, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$iconName.svg',
      semanticsLabel: '$iconName-icon',
      fit: BoxFit.contain,
    );
  }
}
