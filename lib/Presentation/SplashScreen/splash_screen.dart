import 'package:ecommerce_app/Core/extension.dart';
import 'package:flutter/material.dart';

import '../Auth/login_screen.dart';
import '../common/Ragistration/button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: context.screenHeight(context)*0.4,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                      image: AssetImage('assets/LoginScreen/images.png'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: context.screenHeight(context)*0.19,
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
            SizedBox(height: context.screenHeight(context)*0.175),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                child: const Button(buttonName: 'Get Started',),
              ),
            )
          ],
        ),
      ),
    );
  }
}
