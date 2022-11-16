import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/copyable_text.dart';
import '../bloc/settings/settings_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsBloc _settings_bloc = SettingsBloc();

  @override
  void initState() {
    super.initState();
    _settings_bloc.add(LoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
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
                    child: BlocProvider(
                      create: (context) => _settings_bloc,
                      child: BlocConsumer<SettingsBloc, SettingsState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          if (state is Initial || state is Loading) {
                            return const Center(
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is Loaded) {
                            return userDataView(context, state);
                          } else {
                            return const Text("Unexpected Error");
                          }
                        },
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("App version : "),
                        Text(
                          "v0.1-beta",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ]))
            ],
          ),
        ),
      )),
    );
  }

  Widget userDataView(context, Loaded state) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Notice: To recover your account you will need private key and contract address",
                  style: TextStyle(color: Colors.red, fontSize: 12.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Private Key:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    CopyableText((state.privateKey))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Contract Address:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    CopyableText(state.contractAddress)
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Edit your details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.email),
                    TextButton(onPressed: () {}, child: const Text("Edit"))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.phone),
                    TextButton(onPressed: () {}, child: const Text("Edit"))
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
