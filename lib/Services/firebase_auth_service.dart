import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_management_system/Screens/auth/sign_in_screen.dart';
import 'package:hotel_management_system/Screens/auth/sign_up_screen.dart';
import 'package:hotel_management_system/Services/firebase_services.dart';

class FirebaseAuthService {
  static Future<String> signIn(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        return "invalid-credential";
      } else {
        return "error";
      }
    }
  }

  static signUp(
      {required String email,
      required String password,
      required String name,
      required String address,
      required String mobileNo}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        FirebaseServices.addSignUpData(
            email: email, name: name, adress: address, mobileNo: mobileNo);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
