import 'package:flutter/material.dart';
import 'package:iblock/services/secure_storage_service.dart';

import '../../widgets/copyable_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (snapshot.hasError){
          Navigator.popAndPushNamed(context, "/error", arguments: {"message": "Encountered an error"});
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else{
          return Scaffold(
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height -100,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Private Key:"),
                                        CopyableText((snapshot.data! as Map)["private-key"] as String)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Contract Address:"),
                                        CopyableText((snapshot.data! as Map)["contract-address"] as String)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("App version : "),
                                  Text("v0.1-beta", style: TextStyle(color: Theme.of(context).primaryColor),)
                                ]))
                      ],
                    ),
                  ),
                )),
          );
        }
      }
    );
  }

  Future<Map<String, String>> loadData() async{
    var privateKey = await SecureStorageService.get("private-key");
    var contractAddress = await SecureStorageService.get("contract-address");
    return {
      "private-key" : privateKey as String,
      "contract-address": contractAddress as String
    };
  }
}
