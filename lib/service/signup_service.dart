import 'package:firebase_auth/firebase_auth.dart';

class SignupService {
  static Future<UserCredential> SignUpWithEmail(
      {required String email, required String password}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return userCredential;
  }

  static Future<UserCredential> LoginWithEmail(
      {required String email, required String password}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    return userCredential;
  }
}



