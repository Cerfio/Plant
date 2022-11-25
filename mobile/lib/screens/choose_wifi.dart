import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_iot_epitech/ui/cards/wifi_card.dart';

class ChooseWifi extends StatefulWidget {
  const ChooseWifi({super.key});

  @override
  State<ChooseWifi> createState() => _ChooseWifiState();
}

class _ChooseWifiState extends State<ChooseWifi> {
  final Widget logo = SvgPicture.asset(
    'assets/logos/plant.svg',
    semanticsLabel: 'plant',
    fit: BoxFit.contain,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xffF9FAF7),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(24),
                  width: 288,
                  height: 80,
                  child: logo,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Choose your Wi-Fi',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff708265),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: ListWifi(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Wifi {
  String name;
  double powerOfSignal;

  Wifi(this.name, this.powerOfSignal);
}

class ListWifi extends StatefulWidget {
  const ListWifi({super.key});

  @override
  State<ListWifi> createState() => _ListWifiState();
}

class _ListWifiState extends State<ListWifi> {
  final int _listLength = 20;
  final List<Wifi> _wifiList = [];

  void generateWifi() {
    for (int i = 0; i < _listLength; i++) {
      _wifiList.add(Wifi('Livebox-$i$i$i$i', -i * 5));
    }
  }

  @override
  void initState() {
    super.initState();
    generateWifi();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _listLength,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (BuildContext context, int index) {
        return WifiCard(
          name: _wifiList[index].name,
          powerOfSignal: _wifiList[index].powerOfSignal,
          isChoosing: true,
        );
      },
    );
  }
}
