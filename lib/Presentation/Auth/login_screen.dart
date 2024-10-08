import 'package:ecommerce_app/Core/extension.dart';
import 'package:ecommerce_app/Presentation/Auth/Ragistration/ragistration_screen.dart';
import 'package:ecommerce_app/Provider/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/Ragistration/button.dart';
import '../common/Ragistration/common_text.dart';
import '../common/Ragistration/google_facebook_Button.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: context.screenHeight(context) * 0.090,
            ),
            const Text(
              'Hi, Welcome! 👋',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.screenHeight(context) * 0.022),
            const Text(
              'Log in to Mono and experience a faster,\neasier way to send and receive money.',
              style: TextStyle(fontSize: 21),
            ),
            SizedBox(height: context.screenHeight(context) * 0.040),
            const CommonText(text: 'Email'),
            TextForm(
              controller: emailNameController,
              hint: 'darshan12@gmail.com',
              Icons: Icons.email_outlined,
            ),
            SizedBox(height: context.screenHeight(context) * 0.020),
            const CommonText(text: 'Password'),
            TextForm(
              controller: passWordController,
              hint: '********',
              Icons: Icons.password,
            ),
            SizedBox(height: context.screenHeight(context) * 0.003),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.screenHeight(context) * 0.020),
            Consumer<AuthProvider>(builder: (context, value, child) {
              return GestureDetector(
                onTap: () {
                  value.Login(
                      email: emailNameController.text,
                      password: passWordController.text,
                      context: context);
                },
                child: const Button(
                        buttonName: 'Login',
                      ),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Divider(height: context.screenHeight(context) * 0.020, color: Colors.black54),
            ),
            GestureDetector(
              onTap: () {},
              child:
                  const GoogleFacebookButton(image: 'assets/LoginScreen/google.svg'),
            ),
            SizedBox(height: context.screenHeight(context) * 0.020),
            GestureDetector(
              onTap: () {},
              child: const GoogleFacebookButton(
                  image: 'assets/LoginScreen/facebook.svg'),
            ),
            SizedBox(height: context.screenHeight(context) * 0.020),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?',
                    style: TextStyle(fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) =>  RagistrationScreen(
                          onLocaleChange: (){},
                        ),
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
