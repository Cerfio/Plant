import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/icons/wifi_icon.dart';

class WifiSignalIcon extends StatelessWidget {
  final int powerOfSignal;

  const WifiSignalIcon({super.key, required this.powerOfSignal});

  @override
  Widget build(BuildContext context) {
    if (powerOfSignal >= -50) {
      return const WifiIcon(iconName: 'wifi-strong');
    } else if (powerOfSignal < -50 && powerOfSignal >= -60) {
      return const WifiIcon(iconName: 'wifi-good');
    } else if (powerOfSignal < -60 && powerOfSignal >= -70) {
      return const WifiIcon(iconName: 'wifi-fair');
    }
    return const WifiIcon(iconName: 'wifi-weak');
  }
}
