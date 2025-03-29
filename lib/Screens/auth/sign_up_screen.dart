import 'package:flutter/material.dart';
import 'package:hotel_management_system/utils/Validation/validation.dart';
import 'package:hotel_management_system/widgets/custom_button.dart';
import 'package:hotel_management_system/widgets/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameFieldController = TextEditingController();
  String? nameErrorText;
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
        const CustomTextField(
          textFieldName: 'Adress',
        ),
        const CustomTextField(
          textFieldName: 'Email',
        ),
        const CustomTextField(
          textFieldName: 'Mobile Number',
        ),
        const CustomTextField(
          textFieldName: 'Password',
        ),
        CustomButton(
          btn_text: 'Sign Up',
          onTap: () {
            setState(() {
              nameErrorText = Validation.nameValidator(
                  nameFieldValue: nameFieldController.text.toString());
            });
          },
        )
      ],
    );
  }
}
