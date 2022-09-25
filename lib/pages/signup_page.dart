import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/signup/signup_bloc.dart';

import '../widgets/forms/date_input_field.dart';
import '../widgets/forms/select_input_field.dart';
import '../widgets/forms/text_input_field.dart';
import '../widgets/forms/button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignupBloc _signupBloc = SignupBloc();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

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
              TextInputField('Full Name', controller: _nameController),
              TextInputField('Email', controller: _emailController),
              DateInputField('Date of Birth', controller: _dobController),
              TextInputField('Country', controller: _countryController),
              TextInputField('Mobile Number', controller: _mobileNumberController),
              SelectInputField('Gender', const ['Male', 'Female', 'Other'], controller: _genderController),
              const SizedBox(height: 30,),

                BlocProvider(
                  create: (context) => _signupBloc,
                  child: BlocListener<SignupBloc, SignupState>(
                    listener: (context, state) {
                      if (state is Submitted){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Submitting...'),
                          ),
                        );
                      }
                      else if (state is Success) {
                        Navigator.popAndPushNamed(context, '/home',
                        arguments: {
                          'Name': _nameController.text,
                          'Email': _emailController.text,
                          'Date of Birth': _dobController.text,
                          'Country': _countryController.text,
                          'Phone': _mobileNumberController.text,
                          'Gender': _genderController.text
                        });
                      }
                    },
                    child: Button('Sign Up', onPressed: () {
                      if (_validateInputs()){
                        _signupBloc.add(SubmitSignupEvent(
                            name: _nameController.text,
                            email: _emailController.text,
                            dob: _dobController.text,
                            country: _countryController.text,
                            phone: _mobileNumberController.text,
                            gender: _genderController.text
                        ));
                      }
                    }),
                  ),

              ),
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
            content: TextInputField('Enter recovery phrase', controller: TextEditingController(),),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Submit'))
            ],
          );
        });
  }

  bool _validateInputs(){
    return true;
  }
}
