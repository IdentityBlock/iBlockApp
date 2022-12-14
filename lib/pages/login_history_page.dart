import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iblock/widgets/covered_loading.dart';
import 'package:iblock/widgets/history_record.dart';

import '../bloc/settings/settings_bloc.dart';

class LoginHistoryPage extends StatefulWidget {
  const LoginHistoryPage({Key? key}) : super(key: key);

  @override
  State<LoginHistoryPage> createState() => _LoginHistoryPageState();
}

class _LoginHistoryPageState extends State<LoginHistoryPage> {
  final SettingsBloc _settingsBloc = SettingsBloc();

  @override
  void initState() {
    _settingsBloc.add(LoadHistoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login History'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (context) => _settingsBloc,
              child: BlocConsumer<SettingsBloc, SettingsState>(
                listenWhen: (previous, current) => previous != current,
                listener: (context, state) {
                  if (state is Failed){
                    Navigator.of(context).popAndPushNamed('/error', arguments: {
                      "message": state.message
                    });
                  }
                },
                buildWhen: (previous, current) => previous != current && current is Loading || current is HistoryLoaded,
                builder: (context, state) {
                  if (state is Loading) {
                    return const CoveredLoading();
                  } else if (state is HistoryLoaded) {
                    return Column(
                      children: (state.records.isEmpty)?
                          [SizedBox(height: MediaQuery.of(context).size.height*0.8, child: const Center(child: Text("No Data Found"),))]
                          :state.records.map((e) {
                        return HistoryRecord(
                            txhash: e.txhash,
                            verifierName: e.verifierName,
                            verifierContractAddress: e.verifierContractAddress);
                      }).toList(),
                    );
                  } else {
                    return const Center(child: Text("Unexpected State"));
                  }
                },
              ),
            ),
          ),
        ));
  }
}
