import 'package:flutter/material.dart';

import '../widgets/forms/text_input_field.dart';
import '../widgets/forms/button.dart';

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
              TextInputField('Full Name'),
              TextInputField('Email'),
              TextInputField('Date of Birth'),
              TextInputField('Country'),
              TextInputField('Mobile Number'),
              TextInputField('Gender'),
              const SizedBox(height: 30,),
              Button('Sign up', onPressed: (){
                print('Sign up');
                Navigator.popAndPushNamed(context, '/home');
              }),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already had an account?'),
                  TextButton(onPressed: () => _openRecoverAccountDialog(context), child: const Text('Recover it here'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openRecoverAccountDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Recover Account'),
            content: TextInputField('Enter recovery phrase'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Submit'))
            ],
          );
        });
  }
}
