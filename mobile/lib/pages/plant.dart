import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_humidity_air.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_humidity_soil.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_light.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_pressure.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_temperature.dart';
import 'package:plant_iot_epitech/ui/cards_elementary/card_elementary_water.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Plant extends StatelessWidget {
  const Plant({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget tomatoPlant = SvgPicture.asset(
        'assets/plants/tomato_plant.svg',
        semanticsLabel: 'Palm leaf',
        fit: BoxFit.cover);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xffC9DBBD),
      child: SlidingUpPanel(
        panel: Container(
          decoration: const BoxDecoration(
            color: Color(0xffC9DBBD),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Care recommendations",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff8BA07E),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: const [
                        CardElementaryWater(),
                        CardElementaryTemperature(),
                        CardElementaryHumidityAir(),
                        CardElementaryHumiditySoil(),
                        CardElementaryLight(),
                        CardElementaryPressure(),
                      ]),
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text("Aznard",
                        style: TextStyle(fontSize: 32),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: tomatoPlant,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// return Container(
//   decoration: const BoxDecoration(
//     color: Color(0xffC9DBBD),
//     boxShadow: [
//       BoxShadow(color: Colors.green, spreadRadius: 3),
//     ],
//     borderRadius: BorderRadius.only(
//       topLeft: Radius.circular(30.0),
//       topRight: Radius.circular(30.0),
//     ),
//   ),
//   child: const Text("fefef"),
// );
// Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Care recommendations",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xff8BA07E),
//               ),
//             ),
//             Expanded(
//               child: GridView.count(
//                   physics: const NeverScrollableScrollPhysics(),
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 20,
//                   crossAxisSpacing: 20,
//                   children: const [
//                     CardElementaryWater(),
//                     CardElementaryTemperature(),
//                     CardElementaryHumidityAir(),
//                     CardElementaryHumiditySoil(),
//                     CardElementaryLight(),
//                     CardElementaryPressure(),
//                   ]),
//             ),
//           ],
//         ),
//       ),
