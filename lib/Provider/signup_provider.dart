import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Presentation/SplashScreen/Tabs/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Infra/AuthService/auth_service.dart';

class AuthProvider extends ChangeNotifier{

  late UserCredential userCredential;



  SignUp({required String email,required String password,required BuildContext context}) async{
      // setLoading(true);
       userCredential = await AuthService().SignUpWithEmail(email: email, password: password);
       //setLoading(false);
       notifyListeners();
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const TabsScreen(),), (route) => false,);
  }


  Login({required String email,required String password,required BuildContext context}) async{
   // setLoading(true);
    userCredential = await AuthService.LoginWithEmail(email: email, password: password);
    //setLoading(false);
    notifyListeners();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const TabsScreen(),), (route) => false,);
  }

  bool isLogin(){
    if(FirebaseAuth.instance.currentUser==null)return false;
    return true;
  }
}