import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

const Color darkBlue = Color(0xff061526);
const Color neonblue = Color(0xff01F2E8);
const double width = 340;
const double height = 450;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// final FocusNode focusNode = FocusNode();

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: darkBlue,
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: darkBlue,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0B233B).withOpacity(0.15),
                        blurRadius: 15,
                        offset: const Offset(-10, -10),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(15, 15),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: height / 2,
                  left: width / 2,
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) {
                        return Transform.rotate(
                          angle: _animation.value,
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: width,
                            height: height,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  neonblue,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Positioned(
                  bottom: height / 2,
                  right: width / 2,
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) {
                        return Transform.rotate(
                          angle: _animation.value,
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: width,
                            height: height,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  neonblue,
                                  Colors.transparent,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: width - 10,
                    height: height - 10,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color.fromARGB(255, 7, 25, 44),
                    ),
                    child: const LoginForm(),
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

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

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
            'Login',
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
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
            Text(
              'Sign up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
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
          const Flexible(
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
