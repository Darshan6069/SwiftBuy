import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../fire_store_collection.dart';

class AuthService {
  final _fireStore = FirebaseFirestore.instance;

  Future<UserCredential> signUpWithEmail(
      {required String email, required String password}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final userData = {
      'email': userCredential.user?.email,
      'password': password,
      'uid': userCredential.user?.uid
    };
    await _fireStore
        .collection(FireStoreCollection.users)
        .doc(userCredential.user?.uid)
        .set(userData);

    await _fireStore
        .collection(FireStoreCollection.cart)
        .doc(userCredential.user?.uid)
        .set({});

    await _fireStore
        .collection(FireStoreCollection.orders)
        .doc(userCredential.user?.uid)
        .set({});

    return userCredential;
  }

  static Future<UserCredential> loginWithEmail(
      {required String email, required String password}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    return userCredential;
  }

  /// signWith GOOGLE

  // loginWithGoogle() async {
  //   try {
  //     GoogleSignIn google = GoogleSignIn();
  //     final user = await google.signIn();
  //
  //     final GoogleSignInAuthentication? googleAuth = await user?.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //     print(user!.displayName);
  //     print(user!.email);
  //     print(user!.photoUrl);
  //
  //     await FirebaseFirestore.instance.collection('Users').doc().set({
  //       'uid': user.id,
  //       'email': user.email,
  //       'name': user.displayName,
  //       'password': '123456',
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
