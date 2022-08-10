import 'package:flutter/material.dart';
import 'package:iblock/widgets/forms/email_input_field.dart';
import 'package:iblock/widgets/forms/password_input_field.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Sign in', style: TextStyle(fontSize: 30)),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: EmailInputField(),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: PasswordInputField(),
            ),
          ],
        ),
      ),
    );
  }
}
