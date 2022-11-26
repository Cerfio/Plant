import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/main.dart';
import 'package:plant_iot_epitech/providers/auth_provider.dart';
import 'package:plant_iot_epitech/providers/user_provider.dart';
import 'package:plant_iot_epitech/ui/cards/double_text_card.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _disconnectAction() {
    final auth = context.read<AuthProvider>();
    auth.logout().then(
          (result) => {
            if (result['status'] == true)
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MyHomePage();
                    },
                  ),
                )
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>();

    return FutureBuilder(
      future: user.getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                  DoubleTextCard(
                    title: 'Email',
                    subtitle: snapshot.data!.user!.email,
                  ),
                  const SizedBox(height: 24),
                  DoubleTextCard(
                    title: 'First Name',
                    subtitle: snapshot.data!.user!.firstName,
                  ),
                  const SizedBox(height: 24),
                  DoubleTextCard(
                    title: 'Last Name',
                    subtitle: snapshot.data!.user!.lastName,
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: () => _disconnectAction(),
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
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
