import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/main.dart';
import 'package:plant_iot_epitech/providers/plant_provider.dart';
import 'package:provider/provider.dart';

class PlantCreated extends StatefulWidget {
  final String serialNumber;
  const PlantCreated({super.key, required this.serialNumber});

  @override
  State<PlantCreated> createState() => _PlantCreatedState();
}

class _PlantCreatedState extends State<PlantCreated> {
  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    final plant = context.read<PlantProvider>();

    return FutureBuilder(
      future: plant.createPlant(widget.serialNumber),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: const Color(0xffC9DBBD),
              child: SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: MediaQuery.of(context).size.height * 0.15,
                      child: Image.asset('assets/images/cone-left.png'),
                    ),
                    Positioned(
                      right: 0,
                      top: MediaQuery.of(context).size.height * 0.05,
                      child: Image.asset('assets/images/cone-right.png'),
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      top: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${_capitalize(snapshot.data!.plantName!)} has been created",
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                              color: Color(0xff708265),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 60),
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.asset('assets/plants/plant-1.png'),
                          ),
                          const SizedBox(height: 60),
                          ElevatedButton.icon(
                            onPressed: () => {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const MyHomePage();
                                  },
                                ),
                              )
                            },
                            icon: const Icon(Icons.home, size: 24),
                            label: const Text(
                              'Go to home',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffDD822A),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(48),
                                ),
                              ),
                              fixedSize: MaterialStateProperty.all<Size>(
                                const Size(200, 48),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
