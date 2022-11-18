import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/signup/signup_bloc.dart';
import '../widgets/forms/button.dart';
import '../widgets/forms/text_input_field.dart';
import '../widgets/covered_loading.dart';

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
          listenWhen: (previous, current)=> previous != current && current is Success || current is Failed || current is Initial,
          listener: (context, state) {
            if (state is Success) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (router) => false,
                  arguments: state.userInfo);
            } else if (state is Failed) {
              Navigator.pushNamed(context, '/error',
                  arguments: {"message": state.message});
            } else if (state is Initial){
              Navigator.popAndPushNamed(context, '/signup');
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
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text("iBlock", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
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
                          child: Column(
                            children: [
                              const Text(
                                "Your contract address will be sent to your email. Check your email",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              InkWell(
                                onTap: ()=>launchUrl(Uri.parse('mailto:${state.email}')),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(state.email, style: const TextStyle(
                                    decoration: TextDecoration.underline
                                  ),),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(top: 24.0),
                        child: Column(
                          children: [
                            const Text("Did you receive email as deployment is failed / Provided email address is wrong",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12
                            ),),
                            TextButton(
                              onPressed: (){
                                _signupBloc.add(StartOverEvent());
                              },
                              child: const Text("Click here"),
                            ),
                          ],
                        ),)
                      ],
                    ),
                  ),
                ),
              );
            }
            else if (state is Loading || state is Initial){
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
