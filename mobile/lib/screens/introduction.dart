import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_iot_epitech/screens/sign_up.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  final Widget logo = SvgPicture.asset('assets/logos/plant-logo.svg',
      semanticsLabel: 'plant-logo', fit: BoxFit.contain);
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) => {
                setState(() {
                  isLastPage = index == 2;
                })
              },
              children: <Widget>[
                _First(logo: logo),
                _Second(logo: logo),
                _Third(logo: logo),
              ],
            ),
          ),
          Container(
            alignment: const Alignment(0, 1),
            child: SizedBox(
              width: 280,
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: CustomizableEffect(
                      dotDecoration: DotDecoration(
                        width: 8,
                        height: 8,
                        color: const Color(0xff8BA07E),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      activeDotDecoration: DotDecoration(
                        width: 24,
                        height: 8,
                        color: const Color(0xff708265),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignUp();
                            },
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xffC9DBBD),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48),
                          ),
                        ),
                      ),
                      child: Stack(
                        children: const <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Get started',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _First extends StatelessWidget {
  final Widget logo;
  final Widget image = SvgPicture.asset('assets/images/1.svg',
      semanticsLabel: 'image-1', fit: BoxFit.contain);

  _First({required this.logo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: const Color(0xffF9FAF7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(24),
            width: 50,
            height: 72,
            child: logo,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 74),
            width: double.infinity,
            height: 300,
            child: image,
          ),
          SizedBox(
            width: double.infinity,
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  'Welcome to plant',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff708265),
                  ),
                ),
                Text(
                  'Get insights into your plants health',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff8BA07E),
                  ),
                ),
                Text(
                  'When to water them\nWhen to change the soil\nWhen to harvest your fruit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 2,
                    fontSize: 14,
                    color: Color(0xff8BA07E),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Second extends StatelessWidget {
  final Widget logo;
  final image = SvgPicture.asset('assets/images/2.svg',
      semanticsLabel: 'image-2', fit: BoxFit.cover);
  _Second({required this.logo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF9FAF7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(24),
            width: 50,
            height: 72,
            child: logo,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 74),
            width: double.infinity,
            height: 300,
            child: image,
          ),
          SizedBox(
            width: double.infinity,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  'Plant Care',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff708265),
                  ),
                ),
                Text(
                  'We keep you up to date with things to do\nwith your plants to make sure you\'re on\nthe right track.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 16,
                    color: Color(0xff8BA07E),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Third extends StatelessWidget {
  final Widget logo;
  final image = SvgPicture.asset('assets/images/3.svg',
      semanticsLabel: 'image-3', fit: BoxFit.cover);
  _Third({required this.logo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF9FAF7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(24),
            width: 50,
            height: 72,
            child: logo,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 74),
            width: double.infinity,
            height: 300,
            child: image,
          ),
          SizedBox(
            width: double.infinity,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  'Picking Fruit',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff708265),
                  ),
                ),
                Text(
                  'We warn you how your plant is growing\nand when to reap the rewards of your hard\nwork',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 16,
                    color: Color(0xff8BA07E),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
