import 'dart:math';

import 'package:animated_form/constants.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

const double width = 320;
const double height = 450;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 4));

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
    _controller.repeat();

    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(logo),
                  width: 50,
                ),
                SizedBox(width: 10),
                Text(
                  'Flutter Guys',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      color: darkBlue,
                      boxShadow: [
                        blackShadow,
                      ],
                    ),
                  ),
                  Positioned(
                    top: height / 2,
                    left: width / 2,
                    child: NeonBackgroundContainer(
                      alignment: Alignment.topLeft,
                      animation: _animation,
                      colors: [
                        Colors.transparent,
                        neonblue,
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: height / 2,
                    right: width / 2,
                    child: NeonBackgroundContainer(
                      alignment: Alignment.bottomRight,
                      animation: _animation,
                      colors: [
                        neonblue,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: width - 10,
                      height: height - 10,
                      decoration: BoxDecoration(
                        color: lightDarkBlue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: SignInForm(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Or Sign in with',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtherLoginOption(name: google),
                OtherLoginOption(name: apple),
                OtherLoginOption(name: facebook),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Sign in',
          style: TextStyle(
            color: neonblue,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 20),
        CustomInputField('Username'),
        CustomInputField('Password'),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Forget Password',
            style: TextStyle(
              color: neonblue,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: neonblue,
              padding: EdgeInsets.symmetric(horizontal: 30),
            ),
            onPressed: () {},
            child: Text(
              'Sign in',
              style: TextStyle(
                color: darkBlue,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            )),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have an account? ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
            Text(
              'Sign up',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomInputField extends StatelessWidget {
  const CustomInputField(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: neonblue,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 10),
          Flexible(
            child: TextField(
              style: TextStyle(
                color: darkBlue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
              cursorColor: darkBlue,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                filled: true,
                fillColor: neonblue,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NeonBackgroundContainer extends StatelessWidget {
  const NeonBackgroundContainer({
    Key? key,
    required this.colors,
    required this.animation,
    required this.alignment,
  }) : super(key: key);

  final Animation<double> animation;
  final List<Color> colors;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animation.value,
      alignment: alignment,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}

class OtherLoginOption extends StatelessWidget {
  const OtherLoginOption({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: lightDarkBlue,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [blackShadow]),
      child: Image(
        image: AssetImage(name),
        width: 30,
      ),
    );
  }
}
