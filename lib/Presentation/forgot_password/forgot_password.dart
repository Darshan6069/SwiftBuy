import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final forgotPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: forgotPasswordController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: forgotPasswordController.text);
                },
                child: const Text("Forgot password"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
