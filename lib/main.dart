import 'dart:math';

import 'package:flutter/material.dart';

import 'constants.dart';

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
      home: const SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller)
      ..addListener(() => setState(() {}));
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
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
            const SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      color: darkBlue,
                      boxShadow: [blackShadow],
                    ),
                  ),
                  Positioned(
                    top: height / 2,
                    left: width / 2,
                    child: NeonBackgroundContainer(
                      controller: _controller,
                      animation: _animation,
                      alignment: Alignment.topLeft,
                      colors: const <Color>[Colors.transparent, neonblue],
                    ),
                  ),
                  Positioned(
                      bottom: height / 2,
                      right: width / 2,
                      child: NeonBackgroundContainer(
                        controller: _controller,
                        animation: _animation,
                        alignment: Alignment.bottomRight,
                        colors: const <Color>[neonblue, Colors.transparent],
                      )),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: width - 10,
                    height: height - 10,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: lightDarkBlue,
                    ),
                    child: const SignInForm(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Or sign in with',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                OtherSignInOption(google),
                OtherSignInOption(facebook),
                OtherSignInOption(apple),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OtherSignInOption extends StatelessWidget {
  const OtherSignInOption(
    this.name, {
    Key? key,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: lightDarkBlue,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [blackShadow],
      ),
      child: Image(
        image: AssetImage(name),
        width: 30,
      ),
    );
  }
}

class NeonBackgroundContainer extends StatelessWidget {
  const NeonBackgroundContainer({
    Key? key,
    required AnimationController controller,
    required Animation<double> animation,
    required this.alignment,
    required this.colors,
  })  : _controller = controller,
        _animation = animation,
        super(key: key);

  final AnimationController _controller;
  final Animation<double> _animation;
  final Alignment alignment;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Transform.rotate(
            angle: _animation.value,
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
        });
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Sign in',
          style: TextStyle(
            color: neonblue,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 20),
        const CustonTextField(label: 'Username'),
        const CustonTextField(label: 'Password'),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Forget Password?',
            style: TextStyle(
              color: neonblue,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: neonblue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          ),
          child: const Text(
            'Sign in',
            style: TextStyle(
              color: darkBlue,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
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

class CustonTextField extends StatelessWidget {
  const CustonTextField({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: neonblue,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 10),
          const TextField(
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
        ],
      ),
    );
  }
}
