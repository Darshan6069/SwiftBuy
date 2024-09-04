import 'package:ecommerce_app/Presentation/SplashScreen/Auth/Ragistration/ragistration_screen.dart';
import 'package:ecommerce_app/Provider/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/Ragistration/button.dart';
import '../common/Ragistration/textformfeild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: height * 0.090,
            ),
            const Text(
              'Hi, Welcome! 👋',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.022),
            const Text(
              'Log in to Mono and experience a faster,\neasier way to send and receive money.',
              style: TextStyle(fontSize: 21),
            ),
            SizedBox(height: height * 0.040),
            const Text(
              'Email',
              style: TextStyle(fontSize: 20),
            ),
            TextForm(
              controller: emailNameController,
              hint: 'darshan12@gmail.com',
              Icons: Icons.email_outlined,
            ),
            SizedBox(height: height * 0.020),
            const Text(
              'Password',
              style: TextStyle(fontSize: 20),
            ),
            TextForm(
              controller: passWordController,
              hint: '********',
              Icons: Icons.password,
            ),
            SizedBox(height: height * 0.008),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                 child: const Text('Forgot Password',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
              ],
            ),
             SizedBox(height: height*0.020),
            Consumer<AuthProvider>(builder: (context, value, child) {
              return GestureDetector(
                onTap: () {
                  value.Login(
                      email: emailNameController.text,
                      password: passWordController.text,
                      context: context);
                },
                child: Button(
                  buttonName: 'Login',
                ),
              );
            }),
            SizedBox(height: height*0.020),
            Divider(height: height*0.020,color: Colors.black54),
            ColoredBox(
              color: Colors.black87,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/LoginScreen/Google_png.png'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Don\'t have an account?',
                    style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => RagistrationScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text('Sign up',
                      style: TextStyle(color: Colors.purple, fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
