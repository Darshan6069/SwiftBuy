import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/signup_provider.dart';

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
              Consumer<AuthProvider>(
                builder: (context,value,child) {
                  return TextButton(
                    onPressed: () {
                      value.forgotPassword(forgotPasswordController.text);
                    },
                    child: const Text("Forgot password"),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
