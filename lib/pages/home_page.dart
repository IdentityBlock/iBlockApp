import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/initialize/initialize_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final InitializeBloc _initializeBloc = InitializeBloc();

  @override
  void initState() {
    try {
      _initializeBloc.add(SetUserInfoEvent(
          ModalRoute.of(context)!.settings.arguments as Map<String, String>));
    } catch (e) {
      _initializeBloc.add(LoadUserInfoEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/history'),
              icon: const Icon(Icons.history_rounded)),
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              icon: const Icon(Icons.settings))
        ]),
        body: SafeArea(
        child: GestureDetector(
          onPanStart: (details){
            _initializeBloc.add(LoadUserInfoEvent());
          },
          child: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: BlocProvider(
                  create: (context) => _initializeBloc,
                  child: BlocBuilder<InitializeBloc, InitializeState>(
                    builder: (context, state) {
                      if (state is Registered) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image:
                                  Image.asset('assets/images/profile.png').image,
                              width: 100,
                              height: 100,
                            ),
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  state.userInfo["Name"]!,
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                )),
                            Table(
                                children: state.userInfo.entries
                                    .map((e) => TableRow(children: [
                                          Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(e.key,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(e.value))
                                        ]))
                                    .toList())
                          ],
                        );
                      } else if (state is Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const Center(
                          child: Text("Unexpected State"),
                        );
                      }
                    },
                  ),
                ),
              ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/qrcode-reader');
        },
        child: const Icon(Icons.qr_code),
      )
    );
  }
}
