import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iblock/services/secure_storage_service.dart';
import 'package:iblock/services/user_contract_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import './error_page.dart';
import '../widgets/forms/button.dart';

class QRResultPage extends StatefulWidget {
  final Barcode result;
  const QRResultPage(this.result, {Key? key}) : super(key: key);

  @override
  State<QRResultPage> createState() => _QRResultPageState();
}

class _QRResultPageState extends State<QRResultPage> {
  Map<String, dynamic> processQR(Barcode qr) {
    Map<String, dynamic> data = jsonDecode(qr.code!);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    try {
      return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Requesting Information'),
            ),
            body: SizedBox(
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
                                    processQR(widget.result)["verifier-name"],
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
                            var data = processQR(widget.result);
                            var contractService = UserContractService();
                            var contractAddress = await SecureStorageService.get("contract-address") as String;
                            var privateKey = await SecureStorageService.get("private-key") as String;
                            await contractService.verify(data['verifier-contract'], data['token'], contractAddress: contractAddress, privateKey: privateKey);
                          },)),
                      Padding(padding: const EdgeInsets.all(2.0),
                          child: Button("Decline", onPressed: () {
                            Navigator.popUntil(
                                context, ModalRoute.withName("/home"));
                          }, color: Colors.red,)),
                    ],),)
              ],),)
        // Center(
        //   child: Text(result.code != null ? 'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}': 'No result'),
        // ),
      ),);
    } catch(e){
      print(e);
      return const ErrorPage(
        message: "QR code not recognized!",
      );
    }
  }
}
