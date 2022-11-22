import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WifiIcon extends StatelessWidget {
  final String iconName;
  const WifiIcon({super.key, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/icons/$iconName',
      semanticsLabel: 'wifi-weak', fit: BoxFit.contain);
  }
}