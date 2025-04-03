import 'package:flutter/material.dart';
import 'package:hotel_management_system/Services/firebase_auth_service.dart';

import 'package:hotel_management_system/widgets/custom_button.dart';
import 'package:hotel_management_system/widgets/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNoFieldController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? nameErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  String? mobileNoErrorText;
  String? addressErrorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Sign Up",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        CustomTextField(
          textFieldName: 'Name',
          controller: nameFieldController,
          errorText: nameErrorText,
        ),
        CustomTextField(
          textFieldName: 'Adress',
          controller: addressController,
          errorText: addressErrorText,
        ),
        CustomTextField(
          textFieldName: 'Email',
          controller: emailController,
          errorText: emailErrorText,
        ),
        CustomTextField(
          textFieldName: 'Mobile Number',
          controller: mobileNoFieldController,
          errorText: mobileNoErrorText,
        ),
        CustomTextField(
          textFieldName: 'Password',
          controller: passwordController,
          errorText: passwordErrorText,
        ),
        CustomButton(
          btntext: 'Sign Up',
          onTap: () {
            FirebaseAuthService.signUp(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
                address: addressController.text.trim(),
                mobileNo: mobileNoFieldController.text.trim(),
                name: nameFieldController.text.trim());
          },
        )
      ],
    );
  }
}
