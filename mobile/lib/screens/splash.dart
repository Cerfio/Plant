import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_iot_epitech/screens/introduction.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  final logo = SvgPicture.asset('assets/logos/plant.svg',
      semanticsLabel: 'plant logo', fit: BoxFit.contain);

  late final AnimationController _controller;
  late final CurvedAnimation _animation;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    _animation.addListener(() {
      if (_animation.isCompleted) {
        _changeOpacity(1);
        _controller.reverse();
        timer();
      }
    });
    _controller.forward();
    // timer();
  }

  void _changeOpacity(double value) {
    setState(() => _opacity = value);
  }

  Future<void> timer() async {
    await Future.delayed(const Duration(seconds: 2)).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const Introduction();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(0, -50 * (_controller.value)),
                    child: logo,
                  ),
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 500),
                    child: const Text(
                      'Welcome to plant',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff708265),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
