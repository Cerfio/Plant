import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/screens/choose_wifi.dart';
import 'package:plant_iot_epitech/ui/icons/wifi_icon.dart';
import 'package:plant_iot_epitech/screens/enter_wifi_password.dart';

class WifiCard extends StatelessWidget {
  final String name;
  final double powerOfSignal;
  final bool isChoosing;
  const WifiCard({
    super.key,
    required this.name,
    required this.powerOfSignal,
    required this.isChoosing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromARGB(25, 64, 59, 75),
            blurRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 24,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xff8BA07E),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: <Widget>[
              _WifiChecker(powerOfSignal: powerOfSignal),
              const SizedBox(width: 18),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => isChoosing
                          ? EnterWifiPassword(
                              name: name,
                              powerOfSignal: powerOfSignal,
                            )
                          : const ChooseWifi(),
                    ),
                  );
                },
                child: isChoosing
                    ? const Text(
                        'Choose',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff6A6A6A),
                        ),
                      )
                    : const Text(
                        'Change',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff6A6A6A),
                        ),
                      ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _WifiChecker extends StatefulWidget {
  final double powerOfSignal;
  const _WifiChecker({required this.powerOfSignal});

  @override
  State<_WifiChecker> createState() => _WifiCheckerState();
}

class _WifiCheckerState extends State<_WifiChecker> {
  @override
  Widget build(BuildContext context) {
    if (widget.powerOfSignal >= -50) {
      return const WifiIcon(iconName: 'wifi-strong.svg');
    } else if (widget.powerOfSignal < -50 && widget.powerOfSignal >= -60) {
      return const WifiIcon(iconName: 'wifi-good.svg');
    } else if (widget.powerOfSignal < -60 && widget.powerOfSignal >= -70) {
      return const WifiIcon(iconName: 'wifi-fair.svg');
    }
    return const WifiIcon(iconName: 'wifi-weak.svg');
  }
}
