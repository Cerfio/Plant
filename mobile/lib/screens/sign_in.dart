import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_iot_epitech/providers/auth_provider.dart';
import 'package:plant_iot_epitech/screens/home.dart';
import 'package:plant_iot_epitech/screens/sign_up.dart';
import 'package:plant_iot_epitech/ui/inputs/form_text_field_input.dart';
import 'package:plant_iot_epitech/validator/auth_validator.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Widget logo = SvgPicture.asset(
    'assets/logos/plant.svg',
    semanticsLabel: 'plant',
    fit: BoxFit.contain,
  );
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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordIsVisible = false;

  bool isLastPage = false;

  void _signInAction() {
    final auth = context.read<AuthProvider>();
 
    if (_formKey.currentState!.validate() &&
        auth.registeredInStatus != Status.authenticating) {
      auth
          .signIn(
            _emailController.text,
            _passwordController.text,
          )
          .then(
            (result) => {
              if (result['status'] == true)
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Home();
                      },
                    ),
                  )
                }
              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error: $result['message']"),
                    ),
                  )
                }
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xffF9FAF7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(24),
                  width: 288,
                  height: 80,
                  child: logo,
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
                        'Welcome back !',
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
                          label: "Email adress",
                          controller: _emailController,
                          validator: validateEmail,
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
                        Container(
                          margin: const EdgeInsets.only(top: 64),
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () => _signInAction(),
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
                              'Sign In',
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
                        'Don\'t have account ? ',
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
                                return const SignUp();
                              },
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text(
                          'Register',
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
        ),
      ),
    );
  }
}
