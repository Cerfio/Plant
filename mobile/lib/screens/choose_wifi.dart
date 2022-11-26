import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_iot_epitech/providers/wifi_detail_provider.dart';
import 'package:plant_iot_epitech/ui/cards/wifi_card.dart';
import 'package:provider/provider.dart';

class ChooseWifi extends StatefulWidget {
  final String serialNumber;
  const ChooseWifi({super.key, required this.serialNumber});

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
    print('BUILD -- IN CHOOSE WIFI');

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
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: _ListWifi(serialNumber: widget.serialNumber),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ListWifi extends StatefulWidget {
  final String serialNumber;
  const _ListWifi({required this.serialNumber});

  @override
  State<_ListWifi> createState() => _ListWifiState();
}

class _ListWifiState extends State<_ListWifi> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context
          .read<WifiDetailProvider>()
          .getWifi(),
      builder: (context, snapshot) {
        print('BUILD -- _ListWifi');
        if (snapshot.hasData) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.wifis!.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (BuildContext context, int index) {
              return WifiCard(
                name: snapshot.data!.wifis![index].ssid,
                powerOfSignal: snapshot.data!.wifis![index].rssi,
                serialNumber: widget.serialNumber,
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
