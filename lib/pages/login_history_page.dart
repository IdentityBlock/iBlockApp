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
                listener: (context, state) {},
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  if (state is Loading) {
                    return const CoveredLoading();
                  } else if (state is HistoryLoaded) {
                    return Column(
                      children: state.records.map((e) {
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
