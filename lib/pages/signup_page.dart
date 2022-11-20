import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iblock/widgets/covered_loading.dart';

import '../../bloc/signup/signup_bloc.dart';
import '../widgets/forms/button.dart';
import '../widgets/forms/date_input_field.dart';
import '../widgets/forms/select_input_field.dart';
import '../widgets/forms/text_input_field.dart';

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

  final TextEditingController _privateKeyController = TextEditingController();
  final TextEditingController _contractAddressController =
      TextEditingController();

  String _validation = "";
  List<String> countries = [];

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
              const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
              TextInputField('Full Name', controller: _nameController),
              TextInputField('Email', controller: _emailController),
              DateInputField('Date of Birth', controller: _dobController),
              _countriesDropDown(context, _countryController),
              TextInputField('Mobile Number', controller: _mobileNumberController, helpText: "Accepting format +94123456789",),
              SelectInputField('Gender', const ['Male', 'Female', 'Other'], controller: _genderController),
              const SizedBox(height: 10,),
              Text(_validation, style: const TextStyle(color: Colors.red),),
              const SizedBox(height: 10,),
                BlocProvider(
                  create: (context) => _signupBloc,
                  child: BlocListener<SignupBloc, SignupState>(
                    listener: (context, state) {
                      if (state is Submitted) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return const CoveredLoading();
                            });
                    } else if (state is RecoverySubmitted) {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return const CoveredLoading();
                          });
                    } else if (state is PrivateKeyStored) {
                      Navigator.pushNamedAndRemoveUntil(context, '/enter-address', (router)=> false);
                    }  else if (state is Success) {
                      log("Signup succeeded");
                      Navigator.pushNamedAndRemoveUntil(context, '/home',
                          arguments: state.userInfo, (route)=>false);
                    } else if (state is Failed) {
                      Navigator.pushNamed(context, "/error",
                          arguments: {'message': state.message});
                    }
                  },
                    child: Button('Sign Up', onPressed: () {
                      if (_validateInputs()){
                        _signupBloc.add(SubmitSignupEvent(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            dob: _dobController.text.trim(),
                            country: _countryController.text.trim(),
                            phone: _mobileNumberController.text.trim(),
                            gender: _genderController.text.trim()
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
            insetPadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(0),
            title: const Text('Recover Account'),
            content:
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  TextInputField('Enter your private key',
                      controller: _privateKeyController),
                  TextInputField('Enter your contract address',
                      controller: _contractAddressController)
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    _signupBloc.add(RecoverySubmitEvent(
                        privateKey: _privateKeyController.text.trim(),
                        contractAddress: _contractAddressController.text.trim()));
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'))
            ],
          );
        });
  }

  bool _validateInputs(){
    String message = "";
    final emailPattern = RegExp(r"^[a-zA-Z0-9_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
    final phoneNumberPattern = RegExp(r"^\+[0-9]{10,11}$");
    //check for empty fields
    if (_nameController.text.trim() == ""){
      message = "Name field cannot be empty";
    }
    else if (_emailController.text.trim() == ""){
      message = "Email field cannot be empty";
    }
    else if (_dobController.text.trim() == "") {
      message = "Date of Birth field cannot be empty";
    }
    else if (_countryController.text.trim() == ""){
      message = "Country field cannot be empty";
    }
    else if (_mobileNumberController.text.trim() == ""){
      message = "Mobile number field cannot be empty";
    }
    else if (_genderController.text.trim() == ""){
      message = "Gender field cannot be empty";
    }
    else if(! emailPattern.hasMatch(_emailController.text.trim())){
      message = "Not a valid email address";
    }
    else if(! phoneNumberPattern.hasMatch(_mobileNumberController.text.trim())){
      message = "Mobile number is not in valid format";
    }

    if(message == ""){
      return true;
    }
    else{
      setState(() {
        _validation = message;
      });
      return false;
    }
  }

  Widget _countriesDropDown(BuildContext context, TextEditingController controller){
    return BlocProvider(
      create: (context) => _signupBloc,
      child: BlocBuilder<SignupBloc,SignupState>(
        buildWhen: ((previous, current) => previous is! Loaded && current is Loaded),
        builder: (context, state){
          if (state is Initial){
            _signupBloc.add(LoadEvent());
          }
          else if (state is Loaded){
              countries = state.countries;
              return SelectInputField("Country", countries, controller: controller);
          }
          return CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,);

        },
      )

    );
  }
}
