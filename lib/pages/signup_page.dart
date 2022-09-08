import 'package:flutter/material.dart';

import '../widgets/forms/text_input_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset('assets/images/icon.png'),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
              const TextInputField('Full Name'),
              const TextInputField('Email'),
              const TextInputField('Date of Birth'),
              const TextInputField('Country'),
              const TextInputField('Mobile Number'),
              const TextInputField('Gender')
            ],
          ),
        ),
      ),
    );
  }
}
