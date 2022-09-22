import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/initialize/initialize_bloc.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({Key? key}) : super(key: key);

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  final InitializeBloc _initializeBloc = InitializeBloc();

  @override
  void initState() {
    super.initState();
    _initializeBloc.add(InitializeAppEvent());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: Image.asset('assets/images/icon.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('iBlock', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 40,
            ),
            const CircularProgressIndicator(color: Colors.greenAccent,),
            const SizedBox(
              height: 20,
            ),

            BlocProvider(
              create: (context) => _initializeBloc,
              child: BlocListener<InitializeBloc, InitializeState>(
                listener: (context, state) {
                  if (state is NotRegistered) {
                      Navigator.popAndPushNamed(context, '/welcome1');
                  }
                  else if (state is Registered) {
                    Navigator.popAndPushNamed(context, '/home');
                  }
                },
                child: const Text('Initializing...'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToWelcomeScreen1(BuildContext context) {
    Navigator.popAndPushNamed(context, '/welcome1');
  }
}
