import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/providers/plant_provider.dart';
import 'package:plant_iot_epitech/ui/cards/plant_status.dart';
import 'package:provider/provider.dart';

class MyPlants extends StatelessWidget {
  const MyPlants({super.key});

  @override
  Widget build(BuildContext context) {
    Future<PlantsOutput> plants =
        Provider.of<PlantProvider>(context, listen: false).getPlants();

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color(0xffF9FAF7),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'My plants',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff708265),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: FutureBuilder(
                  future: plants,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:
                              (MediaQuery.of(context).size.width / 2 / 280),
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 24,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.plants?.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return PlantStatus(
                            id: snapshot.data!.plants![index].id,
                            name: snapshot.data!.plants![index].name,
                            type: '1',
                            waterStatus: snapshot
                                .data!.plants![index].datas[0].humiditySoil,
                            lightStatus:
                                snapshot.data!.plants![index].datas[0].light,
                            temperatureStatus: snapshot
                                .data!.plants![index].datas[0].temperature,
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
