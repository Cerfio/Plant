import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_iot_epitech/models/user.dart';
import 'package:plant_iot_epitech/providers/auth_provider.dart';
import 'package:plant_iot_epitech/screens/introduction.dart';
import 'package:plant_iot_epitech/screens/my_plants.dart';
import 'package:plant_iot_epitech/screens/notifications.dart';
import 'package:plant_iot_epitech/screens/profile.dart';
import 'package:plant_iot_epitech/screens/home.dart';
import 'package:plant_iot_epitech/screens/sign_in.dart';
import 'package:plant_iot_epitech/storage/user_preferences.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<bool> userFirstTime = UserPreferences().getUserFirstTime();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const MyHomePage(),
        home: FutureBuilder(
          future: userFirstTime,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return const Introduction();
              } else {
                return const MyHomePage();
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final PageController _controller = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<String> token = UserPreferences().getUserToken();

    return FutureBuilder(
      future: token,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == "") {
            return const SignIn();
          } else {
            return Scaffold(
              body: PageView(
                controller: _controller,
                onPageChanged: (index) => {
                  _onItemTapped(index),
                },
                children: const <Widget>[
                  Home(),
                  MyPlants(),
                  Notifications(),
                  Profile(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined, size: 32),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.eco_outlined, size: 32),
                    label: 'My plants',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_outlined, size: 32),
                    label: 'Notifications',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined, size: 32),
                    label: 'Settings',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: const Color(0xff8BA07E),
                onTap: (index) => {
                  _onItemTapped(index),
                  _controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  )
                },
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
