import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iblock/widgets/covered_loading.dart';

import '../bloc/signup/signup_bloc.dart';
import '../widgets/forms/button.dart';
import '../widgets/forms/text_input_field.dart';

class EnterAddressPage extends StatefulWidget {
  const EnterAddressPage({Key? key}) : super(key: key);

  @override
  State<EnterAddressPage> createState() => _EnterAddressPageState();
}

class _EnterAddressPageState extends State<EnterAddressPage> {
  final SignupBloc _signupBloc = SignupBloc();

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _signupBloc.add(AcceptingContractAddressEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _signupBloc,
        child: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is Success) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (router) => false,
                  arguments: state.userInfo);
            } else if (state is Failed) {
              Navigator.pushNamed(context, '/error',
                  arguments: {"message": state.message});
            }
            else{
              Navigator.popAndPushNamed(context, "/error", arguments: {"message": "unexpected Error"});
            }
          },
          buildWhen: (previous, current)=> previous != current && current is PrivateKeyStored || current is Loading,
          builder: (context, state){
            if (state is PrivateKeyStored){
              return SafeArea(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset('assets/images/icon.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: TextInputField("Enter Contract Address:",
                              controller: _controller),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Button(
                              "Submit",
                              onPressed: () {
                                _signupBloc.add(ContractAddressSubmitEvent(contractAddress: _controller.text.trim()));
                              },
                            )),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(10.0)),
                          padding: const EdgeInsets.all(8.0),
                          margin:
                          const EdgeInsets.only(left: 36, right: 36, top: 40),
                          child: const Text(
                            "Your contract address will be sent to your email. Check your email",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            else if (state is Loading){
              return const CoveredLoading();
            }
            else{
              return const Center(child: Text("Unexpected Error"),);
            }
          },
        ),
      ),
    );
  }
}
