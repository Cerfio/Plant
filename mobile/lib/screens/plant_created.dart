import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/main.dart';

class PlantCreated extends StatefulWidget {
  const PlantCreated({super.key});

  @override
  State<PlantCreated> createState() => _PlantCreatedState();
}

class _PlantCreatedState extends State<PlantCreated> {
  @override
  Widget build(BuildContext context) {
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
                    const Text(
                      "New plant has been created",
                      style: TextStyle(
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
              )
              // Positioned(
              //   width: MediaQuery.of(context).size.width,
              //   top: MediaQuery.of(context).size.width *
              //       0.30, //TRY TO CHANGE THIS **0.30** value to achieve your goal
              //   child: Container(
              //     margin: EdgeInsets.all(16.0),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: <Widget>[
              //         Image.asset('assets/images/appicon.png', scale: 2.5),
              //         SizedBox(
              //           height: 20,
              //         ),
              //         Text(
              //           "SMARTID",
              //           style: TextStyle(
              //               fontSize: 30,
              //               color: Colors.white,
              //               fontFamily: 'Open Sans',
              //               fontWeight: FontWeight.bold),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}