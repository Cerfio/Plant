import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/ui/cards/double_text_card.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xffF9FAF7),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Color(0xff708265),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Personal Informations',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff8BA07E),
              ),
            ),
            const SizedBox(height: 32),
            const DoubleTextCard(
              title: 'Email',
              subtitle: 'zhiwen.wang@epitech.eu',
            ),
            const SizedBox(height: 24),
            const DoubleTextCard(
              title: 'First Name',
              subtitle: 'Zhiwen',
            ),
            const SizedBox(height: 24),
            const DoubleTextCard(
              title: 'Last Name',
              subtitle: 'Wang',
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => print('Press on disconnected'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(MediaQuery.of(context).size.width, 80),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: const Text(
                'Disconnect',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff980A0A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}