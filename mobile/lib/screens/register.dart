import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_iot_epitech/ui/inputs/form_text_field_input.dart';
import 'package:plant_iot_epitech/validator/auth_validator.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Widget logo = SvgPicture.asset('assets/logos/plant.svg',
      semanticsLabel: 'plant', fit: BoxFit.contain);
  final PageController _controller = PageController();
  final TextEditingController emailController = TextEditingController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _controller,
          onPageChanged: (index) => {
            setState(() {
              isLastPage = index == 2;
            })
          },
          children: <Widget>[
            _First(logo: logo, emailController: emailController),
            _Second(logo: logo),
          ],
        ),
      ),
    );
  }
}

class _First extends StatefulWidget {
  final Widget logo;
  final TextEditingController emailController;
  const _First({
    Key? key,
    required this.logo,
    required this.emailController,
  }) : super(key: key);

  @override
  State<_First> createState() => __FirstState();
}

class __FirstState extends State<_First> {
  final _formKey = GlobalKey<FormState>();

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
            width: 288,
            height: 80,
            child: widget.logo,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
            width: double.infinity,
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Register Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff708265),
                  ),
                ),
                Text(
                  'Fill your details or continue\nwith social media',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff8BA07E),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
            width: double.infinity,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FormTextFieldInput(
                    label: "Email adress",
                    controller: widget.emailController,
                    validator: validateEmail,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Second extends StatefulWidget {
  final Widget logo;
  const _Second({
    Key? key,
    required this.logo,
  }) : super(key: key);

  @override
  State<_Second> createState() => __SecondState();
}

class __SecondState extends State<_Second> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
