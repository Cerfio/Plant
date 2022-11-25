import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards/notification_card.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffF9FAF7),
          elevation: 0,
          title: const Center(
            child: Text(
              "Notifications",
              style: TextStyle(
                color: Color(0xff293B1C),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.separated(
            itemCount: 10,
            padding: const EdgeInsets.only(left: 24, right:24, bottom: 24),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (BuildContext context, int index) {
              return const NotificationCard(
                title: 'Plant Alert',
                subtitle: 'Missing water',
                description: 'Please watering Aznard',
              );
            },
          ),
        ),
      ),
    );
  }
}
