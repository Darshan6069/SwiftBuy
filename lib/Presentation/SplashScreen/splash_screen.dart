import 'package:flutter/material.dart';

import 'Auth/login_screen.dart';
import 'common/Ragistration/button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: height*0.4,
              width: width,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                      image: AssetImage('assets/LoginScreen/images.png'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: height*0.19,
            ),
            const Text(
              'MarketKy',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
            ), // Add your illustration image here

            const SizedBox(
              height: 10,
            ),
            const Text(
              'Market in your pocket. Find\n your best outfit here.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height*0.212),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: Button(buttonName: 'Get Started',),
            )
          ],
        ),
      ),
    );
  }
}
