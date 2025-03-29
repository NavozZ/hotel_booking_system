import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/Screens/auth/sign_in_screen.dart';
import 'package:hotel_management_system/Screens/auth/sign_up_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignInPage = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSignInPage ? SignIn() : SignUp(),
          RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: isSignInPage
                      ? "You Don't have an account?"
                      : "Already you have an account please  ",
                  style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: isSignInPage ? "SignUp" : "SignIn",
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        isSignInPage = !isSignInPage;
                      });
                    })
            ]),
          )
        ],
      ),
    );
  }
}
