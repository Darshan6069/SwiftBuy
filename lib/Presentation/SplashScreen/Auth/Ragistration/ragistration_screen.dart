import 'package:ecommerce_app/Presentation/SplashScreen/Tabs/tabs.dart';
import 'package:ecommerce_app/Provider/signup_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/Ragistration/button.dart';
import '../../common/Ragistration/textformfeild.dart';

class RagistrationScreen extends StatefulWidget {
  const RagistrationScreen({super.key});

  @override
  State<RagistrationScreen> createState() => _RagistrationScreenState();
}

class _RagistrationScreenState extends State<RagistrationScreen> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: height - 790,
            ),
            const Text(
              'Create an account',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Create an account to manage your\n money transfer with Mono. ',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text('FullName'),
            TextForm(controller: nameController,hint:'Savaliya Darshan',Icons: Icons.person,),

            const SizedBox(height: 30),
            const Text('Email'),
            TextForm(controller: emailControler,hint:'darshan12@gmail.com',Icons: Icons.email_outlined,),

            const SizedBox(height: 20),
            const Text('Password'),
            TextForm(controller: passWordController,hint:'********',Icons: Icons.password,),

            const SizedBox(height: 30),
            Consumer<AuthProvider>(
              builder: (context,value,child) {
                return GestureDetector(
                  onTap: () {
                    value.SignUp(email: emailControler.text, password: passWordController.text, context: context);
                  },
                  child: Button(buttonName: 'Sign Up',),
                );
              }
            ),
            const SizedBox(height: 30),
            const Text('------------Or sign in with:-------------'),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/LoginScreen/Google_png.png'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Already have an account?',
                    style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () {},
                  child: const Text('Sign in',
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
