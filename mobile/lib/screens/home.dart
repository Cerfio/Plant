import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/screens/read_qr_code.dart';
import 'package:plant_iot_epitech/ui/cards/plant_status.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pc = PanelController();
  bool panelIsOpen = false;

  void changePanelState() {
    setState(() {
      panelIsOpen = !panelIsOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xffC9DBBD),
      child: SlidingUpPanel(
        parallaxEnabled: true,
        panelSnapping: true,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
        maxHeight: MediaQuery.of(context).size.height,
        minHeight: 460,
        controller: pc,
        panelBuilder: (ScrollController sc) => Container(
          decoration: const BoxDecoration(
            color: Color(0xffF9FAF7),
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          child: _scrollingList(sc, pc, context),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                "Hello, Cerfio",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff708265),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Let's start taking care of your plants now",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff8BA07E),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ReadQrCode();
                    },
                  ),
                )
              },
              icon: const Icon(Icons.add, size: 24),
              label: const Text(
                'Add a plant',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xffDD822A),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(200, 48),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 117,
                  height: 117,
                  child: Image.asset('assets/plants/flower-plant.png'),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 106,
                  height: 106,
                  child: Image.asset('assets/plants/smiling-flower-plant.png'),
                ),
                SizedBox(
                  width: 117,
                  height: 117,
                  child: Image.asset('assets/plants/flower-plant.png'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _scrollingList(
      ScrollController sc, PanelController pc, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 52),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
        controller: sc,
        children: [
          Center(
            child: Container(
              width: 100,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Recent Plants',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff708265),
                ),
              ),
              TextButton(
                onPressed: () => {
                  if (panelIsOpen)
                    {pc.close(), changePanelState()}
                  else
                    {pc.open(), changePanelState()},
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                ),
                child: const Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffDD822A),
                  ),
                ),
              ),
            ],
          ),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: (MediaQuery.of(context).size.width / 2 / 280),
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: const <Widget>[
              PlantStatus(
                name: 'Tomato',
                type: '1',
                waterStatus: 0.33,
                lightStatus: 0.66,
                temperatureStatus: 1,
              ),
              PlantStatus(
                name: 'Persil',
                type: '2',
                waterStatus: 0.66,
                lightStatus: 0.67,
                temperatureStatus: 1,
              ),
              PlantStatus(
                name: 'Strawberry',
                type: '3',
                waterStatus: 0.99,
                lightStatus: 0.67,
                temperatureStatus: 1,
              ),
              PlantStatus(
                name: 'Sunflower',
                type: '4',
                waterStatus: 0.99,
                lightStatus: 0.67,
                temperatureStatus: 1,
              ),
              PlantStatus(
                name: 'Sunflower',
                type: '4',
                waterStatus: 0.99,
                lightStatus: 0.67,
                temperatureStatus: 1,
              ),
              PlantStatus(
                name: 'Sunflower',
                type: '4',
                waterStatus: 0.99,
                lightStatus: 0.67,
                temperatureStatus: 1,
              ),
              PlantStatus(
                name: 'Sunflower',
                type: '4',
                waterStatus: 0.99,
                lightStatus: 0.67,
                temperatureStatus: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
