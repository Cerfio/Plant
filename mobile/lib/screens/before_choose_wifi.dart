import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_iot_epitech/screens/choose_wifi.dart';
import 'package:plant_iot_epitech/ui/cards/wifi_card.dart';

class BeforeChooseWifi extends StatelessWidget {
  BeforeChooseWifi({super.key});

  final Widget logo = SvgPicture.asset(
    'assets/logos/plant.svg',
    semanticsLabel: 'plant',
    fit: BoxFit.contain,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Choose your Wi-Fi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff708265),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ChooseWifi();
                      },
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xffC9DBBD),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(327, 48),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48),
                    ),
                  ),
                ),
                child: const Text(
                  'I have switched of WIFI',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
