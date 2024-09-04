import 'package:ecommerce_app/Presentation/SplashScreen/Tabs/tabs.dart';
import 'package:ecommerce_app/service/signup_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{

  late UserCredential userCredential;

  SignUp({required String email,required String password,required BuildContext context}) async{
       userCredential = await SignupService.SignUpWithEmail(email: email, password: password);
       notifyListeners();
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => TabsScreen(),), (route) => false,);
  }


  Login({required String email,required String password,required BuildContext context}) async{
    userCredential = await SignupService.LoginWithEmail(email: email, password: password);
    notifyListeners();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => TabsScreen(),), (route) => false,);
  }
}