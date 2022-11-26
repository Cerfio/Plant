import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/screens/enter_wifi_password.dart';
import 'package:plant_iot_epitech/ui/icons/wifi_signal_icon.dart';

class WifiCard extends StatelessWidget {
  final String name;
  final int powerOfSignal;
  final String serialNumber;

  const WifiCard({
    super.key,
    required this.name,
    required this.powerOfSignal,
    required this.serialNumber,
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
              WifiSignalIcon(powerOfSignal: powerOfSignal),
              const SizedBox(width: 18),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnterWifiPassword(
                        name: name,
                        powerOfSignal: powerOfSignal,
                        serialNumber: serialNumber,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Choose',
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
