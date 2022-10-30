import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final logo = SvgPicture.asset('assets/logos/plant.svg',
        semanticsLabel: 'plant logo', fit: BoxFit.contain);

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: logo,
        ),
      ),
    );
  }
}
