import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_iot_epitech/screens/sign_in.dart';
import 'package:plant_iot_epitech/ui/inputs/form_text_field_input.dart';
import 'package:plant_iot_epitech/validator/auth_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final Widget logo = SvgPicture.asset(
    'assets/logos/plant.svg',
    semanticsLabel: 'plant',
    fit: BoxFit.contain,
  );
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
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            _First(
              logo: logo,
              pageController: _controller,
              emailController: emailController,
            ),
            _Second(
              logo: logo,
              emailController: emailController,
            ),
          ],
        ),
      ),
    );
  }
}

class _First extends StatefulWidget {
  final Widget logo;
  final PageController pageController;
  final TextEditingController emailController;
  const _First({
    Key? key,
    required this.logo,
    required this.pageController,
    required this.emailController,
  }) : super(key: key);

  @override
  State<_First> createState() => __FirstState();
}

class __FirstState extends State<_First> {
  final _formKey = GlobalKey<FormState>();
  final Widget googleLogo = SvgPicture.asset(
    'assets/logos/google.svg',
    semanticsLabel: 'google-logo',
    fit: BoxFit.contain,
  );
  final Widget facebookLogo = SvgPicture.asset(
    'assets/logos/facebook.svg',
    semanticsLabel: 'google-logo',
    fit: BoxFit.contain,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FormTextFieldInput(
                      label: "Email adress",
                      controller: widget.emailController,
                      validator: validateEmail,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 64),
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
                            );
                          }
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
                        child: const Text(
                          'Sign Up',
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
            Container(
              margin: const EdgeInsets.only(top: 32, bottom: 24),
              width: double.infinity,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(
                    width: 30,
                    height: 2,
                    child: Divider(
                      color: Color(0xff708265),
                      thickness: 2,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    'Or Continue with',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff708265),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 2,
                    child: Divider(
                      color: Color(0xff708265),
                      thickness: 2,
                      indent: 10,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: googleLogo,
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: facebookLogo,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Already have an account ? ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8BA07E),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignIn();
                          },
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff708265),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Second extends StatefulWidget {
  final Widget logo;
  final TextEditingController emailController;
  const _Second({
    Key? key,
    required this.logo,
    required this.emailController,
  }) : super(key: key);

  @override
  State<_Second> createState() => __SecondState();
}

class __SecondState extends State<_Second> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        reverse: true,
        child: Container(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
                width: double.infinity,
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'SignUp Account',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FormTextFieldInput(
                        label: "First Name",
                        controller: _firstNameController,
                        validator: validateFirstName,
                      ),
                      const SizedBox(height: 20),
                      FormTextFieldInput(
                        label: "Last Name",
                        controller: _lastNameController,
                        validator: validateLastName,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        validator: validatePassword,
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
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPasswordController,
                        validator: (value) => validateConfirmPassword(
                            value, _passwordController.text),
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
                          labelText: "Confirm Password",
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
                        margin: const EdgeInsets.only(top: 58),
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
                            'Sign Up',
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
    );
  }
}
