import 'package:ecommerce_app/Core/extension.dart';
import 'package:ecommerce_app/Presentation/SplashScreen/Screens/order_details_screen.dart';
import 'package:ecommerce_app/Presentation/common/Ragistration/button.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          GestureDetector(
              onTap: () {
                context.push(
                  context,
                  target: const OrderDetailsScreen(),
                );
              },
              child: const Button(buttonName: 'Order Product'))
        ],
      ),
    );
  }
}
