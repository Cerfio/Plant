import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/icons/plant_status_icon.dart';

class IconProgressBar extends StatelessWidget {
  final String iconName;
  final double value;

  const IconProgressBar({
    super.key,
    required this.iconName,
    required this.value,
  });

  Color getColorByValue() {
    if (value <= 0.33) {
      return const Color(0xffB92323);
    } else if (value > 0.33 && value <= 0.66) {
      return const Color(0xffDD822A);
    }
    return const Color(0xff8BA07E);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          PlantStatusIcon(iconName: iconName),
          SizedBox(
            height: 8,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: LinearProgressIndicator(
                value: value,
                valueColor: AlwaysStoppedAnimation<Color>(getColorByValue()),
                backgroundColor: const Color(0xffE3E5E6),
              ),
            ),
          )
        ],
      ),
    );
  }
}
