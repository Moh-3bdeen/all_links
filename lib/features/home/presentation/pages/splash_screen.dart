import 'dart:async';
import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/router_list.dart';
import '../../../../infrastacture/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Duration duration = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });

    log("Value is: ${SharedPrefController.getData(key: Keys.isLogged.name)}");
    Timer(
      const Duration(milliseconds: 3000),
      () => Navigator.pushReplacementNamed(
        context,
        SharedPrefController.getData(key: Keys.isLogged.name) != null &&
                SharedPrefController.getData(key: Keys.isLogged.name) != false
            ? RouterList.pageViewApp
            : RouterList.loginScreen,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: controller.value * 200,
                  width: controller.value * 200,
                  child: Image.asset('assets/images/logo.jpg'),
                ),
              ),
              const SizedBox(height: 16),
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'All Links',
                    textStyle: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
