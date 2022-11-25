import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_iot_epitech/ui/cards/wifi_card.dart';
import 'package:plant_iot_epitech/validator/wifi_validator.dart';

class EnterWifiPassword extends StatefulWidget {
  final String name;
  final double powerOfSignal;
  const EnterWifiPassword(
      {super.key, required this.name, required this.powerOfSignal});

  @override
  State<EnterWifiPassword> createState() => _EnterWifiPasswordState();
}

class _EnterWifiPasswordState extends State<EnterWifiPassword> {
  final Widget logo = SvgPicture.asset(
    'assets/logos/plant.svg',
    semanticsLabel: 'plant',
    fit: BoxFit.contain,
  );
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xffF9FAF7),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(24),
                  width: 288,
                  height: 80,
                  child: logo,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Enter Wi-Fi password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff708265),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: WifiCard(
                    name: widget.name,
                    powerOfSignal: widget.powerOfSignal,
                    isChoosing: false,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: _passwordController,
                          validator: validateWiFiPassword,
                          obscureText: !_passwordIsVisible,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffE3E5E6),
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: "Password",
                            labelStyle: const TextStyle(
                              color: Color(0xff72777A),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordIsVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color(0xff72777A),
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordIsVisible = !_passwordIsVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 64),
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // widget.pageController.animateToPage(
                                //   1,
                                //   duration: const Duration(milliseconds: 300),
                                //   curve: Curves.linear,
                                // );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffC9DBBD),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(48),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Connect',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
