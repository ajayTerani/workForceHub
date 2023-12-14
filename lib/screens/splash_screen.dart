import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var baseColour =  Theme.of(context).backgroundColor;
    return Scaffold(
      backgroundColor: baseColour,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "WorkForceHub",
              style: TextStyle(
                  fontSize: width * 0.08, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              "assets/images/image.png",
              width: width*.6,
              height: height*.6,
            ),

          ],
        ),
      ),
    );
  }
}
