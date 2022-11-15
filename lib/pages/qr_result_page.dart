import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../widgets/forms/button.dart';
import '../bloc/verify/verify_bloc.dart';

class QRResultPage extends StatefulWidget {
  final Barcode result;
  const QRResultPage(this.result, {Key? key}) : super(key: key);

  @override
  State<QRResultPage> createState() => _QRResultPageState();
}

class _QRResultPageState extends State<QRResultPage> {
  final VerifyBloc _verifyBloc = VerifyBloc();

  @override
  void initState() {
    super.initState();
    _verifyBloc.add(QRDetectedEvent(widget.result));
  }

  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Requesting Information'),
            ),
            body:
                BlocProvider(
                  create: (context) => _verifyBloc,
                  child: BlocConsumer<VerifyBloc, VerifyState>(
                    listener: (context, state){
                      if (state is Failed){
                        Navigator.popAndPushNamed(context, "/error", arguments: {"message": state.message});
                      }
                      else if(state is Verified){
                        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                      }
                    },
                    buildWhen: (previous, current)=> previous != current && (current is QRDetected || current is Submitted),
                    builder: (context, state){
                      if(state is QRDetected){
                        return SizedBox(
                          width: double.infinity,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: MediaQuery.of(context).size.width >
                                      MediaQuery.of(context).size.height
                                      ? 1
                                      : 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.6,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                    "Following service provider request your approval for access your personal information")),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                state.verifierName,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: SizedBox(
                                                width: 300,
                                                child: Image(
                                                    image: AssetImage(
                                                        'assets/images/contract-agreement.png')),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(flex: 1,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(padding: const EdgeInsets.all(2.0),
                                        child: Button("Approve", onPressed: () async{
                                          _verifyBloc.add(Verify(state.verifierContractAddress, state.token));
                                        },)),
                                    Padding(padding: const EdgeInsets.all(2.0),
                                        child: Button("Decline", onPressed: () {
                                          Navigator.popUntil(
                                              context, ModalRoute.withName("/home"));
                                        }, color: Colors.red,)),
                                  ],),)
                            ],),);
                      }
                      else if(state is Submitted){
                        return const Center(
                          child: SizedBox(
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      else{
                        return AlertDialog(
                          title: const Text("Error"),
                          content: const Text("Unexpected Error!"),
                          actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          },
                              child: const Text("Go Back"))
                        ],);
                      }
                    },
                  ),
         )
      ),);
  }
}
