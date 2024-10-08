import 'dart:ffi';

import 'package:ecommerce_app/Core/extension.dart';
import 'package:ecommerce_app/Provider/signup_provider.dart';
import 'package:ecommerce_app/core/app_locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';

import '../../common/Ragistration/button.dart';
import '../../common/Ragistration/common_text.dart';
import '../../common/Ragistration/google_facebook_Button.dart';
import '../../common/Ragistration/textformfeild.dart';
import '../../forgot_password/forgot_password.dart';
import '../login_screen.dart';

class RagistrationScreen extends StatefulWidget {
  const RagistrationScreen({
    super.key,
    required this.onLocaleChange,
  });

  final VoidCallback onLocaleChange;

  @override
  State<RagistrationScreen> createState() => _RagistrationScreenState();
}

class _RagistrationScreenState extends State<RagistrationScreen> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final FlutterLocalization localization = FlutterLocalization.instance;

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
            Text(
              AppLocale.title.getString(context),
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.screenHeight(context) * 0.022),
            const Text(
              'Create an account to manage your\nmoney transfer with Mono. ',
              style: TextStyle(fontSize: 21),
            ),
            SizedBox(height: context.screenHeight(context) * 0.030),
            const CommonText(text: 'Full Name'),
            TextForm(
              controller: nameController,
              hint: 'Savaliya Darshan',
              Icons: CupertinoIcons.person,
            ),
            SizedBox(height: context.screenHeight(context) * 0.008),
            const CommonText(text: 'Email'),
            TextForm(
              controller: emailControler,
              hint: 'darshan12@gmail.com',
              Icons: Icons.email_outlined,
            ),
            SizedBox(height: context.screenHeight(context) * 0.009),
            const CommonText(text: 'Password'),
            TextForm(
              controller: passWordController,
              hint: '********',
              Icons: Icons.password,
            ),
            SizedBox(height: context.screenHeight(context) * 0.002),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPassword(),
                    ),
                  ),
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.screenHeight(context) * 0.010),
            Consumer<AuthProvider>(builder: (context, value, child) {
              return GestureDetector(
                onTap: () {
                  widget.onLocaleChange();
                  // value.SignUp(
                  //     email: emailControler.text,
                  //     password: passWordController.text,
                  //     context: context);
                },
                child: const Button(
                  buttonName: 'SignUp',
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Divider(
                  height: context.screenHeight(context) * 0.020,
                  color: Colors.black54),
            ),
            GestureDetector(
              onTap: () {},
              child: const GoogleFacebookButton(
                  image: 'assets/LoginScreen/google.svg'),
            ),
            SizedBox(height: context.screenHeight(context) * 0.010),
            GestureDetector(
              onTap: () {},
              child: const GoogleFacebookButton(
                  image: 'assets/LoginScreen/facebook.svg'),
            ),
            SizedBox(height: context.screenHeight(context) * 0.010),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account ,',
                    style: TextStyle(fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text('Sign In',
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
