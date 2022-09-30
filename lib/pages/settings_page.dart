import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text("Private key:"),
                          Text("Ox54s1hk25555dsd48522222", )
                        ],
                      )
                    ],
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
